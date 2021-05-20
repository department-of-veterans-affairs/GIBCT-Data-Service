# frozen_string_literal: true

module V1
  class InstitutionsController < ApiController
    include Facets

    # GET /v1/institutions/autocomplete?term=harv
    def autocomplete
      @data = []
      if params[:term].present?
        @query ||= normalized_query_params
        @search_term = params[:term]&.strip&.downcase
        @data = filter_results(Institution.approved_institutions(@version)).autocomplete(@search_term)
      end
      @meta = {
        version: @version,
        term: @search_term
      }
      @links = { self: self_link }
      render json: { data: @data, meta: @meta, links: @links }, adapter: :json
    end

    # GET /v1/institutions?name=duluth&x=y
    def index
      @query ||= normalized_query_params
      @meta = {
        version: @version,
        count: 0,
        facets: {}
      }

      if @query.key?(:latitude) && @query.key?(:longitude)
        location_results = Institution.approved_institutions(@version).location_search(@query)
        results = location_results.location_select(@query).location_order

        @meta[:count] = location_results.count
        @meta[:facets] = facets(location_results)
      else
        # For sorting by percentage instead whole number
        max_gibill = Institution.approved_institutions(@version).maximum(:gibill) || 0
        results = search_results.search_order(@query, max_gibill).page(page)

        @meta[:count] = results.count
        @meta[:facets] = facets(results)
      end

      render json: results,
             each_serializer: InstitutionSearchResultSerializer,
             meta: @meta
    end

    # GET /v1/institutions/20005123
    def show
      resource = Institution.approved_institutions(@version).find_by(facility_code: params[:id])

      raise Common::Exceptions::RecordNotFound, params[:id] unless resource

      @links = { self: self_link }
      render json: resource, serializer: InstitutionProfileSerializer,
             meta: { version: @version }, links: @links
    end

    # GET /v1/institutions/20005123/children
    def children
      children = Institution.joins(:version)
                            .where(version: @version)
                            .where(parent_facility_code_id: params[:id])
                            .order(:institution)
                            .page(page)

      @meta = {
        version: @version,
        count: children.count
      }
      @links = { self: self_link }
      render json: children,
             each_serializer: InstitutionSerializer,
             meta: @meta,
             links: @links
    end

    private

    def normalized_query_params
      query = params.deep_dup
      query.tap do
        query[:name].try(:strip!)
        %i[state country type].each do |k|
          query[k].try(:upcase!)
        end
        %i[name category student_veteran_group yellow_ribbon_scholarship principles_of_excellence
           eight_keys_to_veteran_success stem_offered independent_study priority_enrollment
           online_only distance_learning location].each do |k|
          query[k].try(:downcase!)
        end
        %i[latitude longitude distance].each do |k|
          query[k] = float_conversion(query[k]) if query[k].present?
        end
      end
    end

    def search_results
      @query ||= normalized_query_params
      relation = Institution.approved_institutions(@version)
                            .search_v1(@query)
      filter_results(relation)
    end

    def filter_results(relation)
      [
        %i[institution_type_name type],
        [:category],
        [:country],
        [:state],
        %i[student_veteran student_veteran_group], # boolean
        %i[yr yellow_ribbon_scholarship], # boolean
        %i[poe principles_of_excellence], # boolean
        %i[eight_keys eight_keys_to_veteran_success], # boolean
        [:stem_offered], # boolean
        [:independent_study], # boolean
        [:online_only],
        [:distance_learning],
        [:priority_enrollment], # boolean
        [:preferred_provider], # boolean
        [:stem_indicator], # boolean
        [:womenonly], # boolean
        [:menonly], # boolean
        [:hbcu], # boolean
        [:relaffil]
      ].each do |filter_args|
        filter_args << filter_args[0] if filter_args.size == 1
        relation = relation.filter_result(filter_args[0], @query[filter_args[1]])
      end

      relation = relation.where('count_of_caution_flags = 0 AND school_closing IS FALSE') if @query[:exclude_warnings]
      relation = relation.where(count_of_caution_flags: 0) if @query[:exclude_caution_flags]

      relation
    end

    # TODO: If filter counts are desired in the future, change boolean facets
    # to use search_results.filter_count(param) instead of default value
    def facets(results)
      institution_types = results.filter_count(:institution_type_name)
      result = {
        category: {
          school: institution_types.except(Institution::EMPLOYER).inject(0) { |count, (_t, n)| count + n },
          employer: institution_types[Institution::EMPLOYER].to_i
        },
        type: institution_types,
        state: results.filter_count(:state),
        country: embed(results.filter_count(:country)),
        student_vet_group: boolean_facet,
        yellow_ribbon_scholarship: boolean_facet,
        principles_of_excellence: boolean_facet,
        eight_keys_to_veteran_success: boolean_facet,
        stem_offered: boolean_facet,
        independent_study: boolean_facet,
        online_only: boolean_facet,
        distance_learning: boolean_facet,
        priority_enrollment: boolean_facet,
        menonly: boolean_facet,
        womenonly: boolean_facet,
        hbcu: boolean_facet,
        relaffil: results.filter_count(:relaffil)
      }

      add_active_search_facets(result)
    end

    def add_active_search_facets(raw_facets)
      add_search_facet(raw_facets, :state)
      add_search_facet(raw_facets, :type)
      add_country_search_facet(raw_facets)
      raw_facets
    end
  end
end
