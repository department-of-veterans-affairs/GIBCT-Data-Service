# frozen_string_literal: true

module V0
  # rubocop:disable Metrics/ClassLength
  class InstitutionsController < ApiController
    include Facets

    # GET /v0/institutions/autocomplete?term=harv
    def autocomplete
      @data = []
      if params[:term]
        @search_term = params[:term]&.strip&.downcase

        @data = approved_institutions.autocomplete(@search_term)
      end
      @meta = {
        version: @version,
        term: @search_term
      }
      @links = { self: self_link }
      render json: { data: @data, meta: @meta, links: @links }, adapter: :json
    end

    # GET /v0/institutions?name=duluth&x=y
    def index
      @meta = {
        version: @version,
        count: search_results.count,
        facets: facets
      }

      if params[:vet_tec_provider] == 'true'
        render json: search_results.order('preferred_provider DESC NULLS LAST, institution')
                                   .page(params[:page]), meta: @meta
      else
        render json: search_results.order(:institution).page(params[:page]), meta: @meta
      end
    end

    # GET /v0/institutions/20005123
    def show
      resource = approved_institutions.find_by(facility_code: params[:id])

      raise Common::Exceptions::RecordNotFound, params[:id] unless resource

      @links = { self: self_link }
      render json: resource, serializer: InstitutionProfileSerializer,
             meta: { version: @version }, links: @links
    end

    # GET /v0/institutions/20005123/children
    def children
      children = Institution.joins(:version)
                            .where(parent_facility_code_id: params[:id])
                            .order(:institution)
                            .page(params[:page])

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
        query[:name].try(:downcase!)
        %i[state country type].each do |k|
          query[k].try(:upcase!)
        end
        %i[category student_veteran_group yellow_ribbon_scholarship principles_of_excellence
           eight_keys_to_veteran_success stem_offered independent_study priority_enrollment
           online_only distance_learning vet_tec_provider].each do |k|
          query[k].try(:downcase!)
        end
      end
    end

    # rubocop:disable Metrics/MethodLength
    def search_results
      @query ||= normalized_query_params
      relation = approved_institutions.search(@query[:name], @query[:include_address])
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
        [:vet_tec_provider], # boolean
        [:preferred_provider], # boolean
        [:stem_indicator] # boolean
      ].each do |filter_args|
        filter_args << filter_args[0] if filter_args.size == 1
        relation = relation.filter(filter_args[0], @query[filter_args[1]])
      end

      relation
    end
    # rubocop:enable Metrics/MethodLength

    # TODO: If filter counts are desired in the future, change boolean facets
    # to use search_results.filter_count(param) instead of default value
    def facets
      institution_types = search_results.filter_count(:institution_type_name)
      result = {
        category: {
          school: institution_types.except(Institution::EMPLOYER).inject(0) { |count, (_t, n)| count + n },
          employer: institution_types[Institution::EMPLOYER].to_i
        },
        type: institution_types,
        state: search_results.filter_count(:state),
        country: embed(search_results.filter_count(:country)),
        student_vet_group: boolean_facet,
        yellow_ribbon_scholarship: boolean_facet,
        principles_of_excellence: boolean_facet,
        eight_keys_to_veteran_success: boolean_facet,
        stem_offered: boolean_facet,
        independent_study: boolean_facet,
        online_only: boolean_facet,
        distance_learning: boolean_facet,
        priority_enrollment: boolean_facet
      }
      add_active_search_facets(result)
    end

    def add_active_search_facets(raw_facets)
      add_search_facet(raw_facets, :state)
      add_search_facet(raw_facets, :type)
      add_country_search_facet(raw_facets)
      raw_facets
    end

    def approved_institutions
      Institution.joins(:version).no_extentions
                 .where(approved: true)
    end
  end
  # rubocop:enable Metrics/ClassLength
end
