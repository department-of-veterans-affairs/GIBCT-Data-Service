# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V0::InstitutionProgramsController, type: :controller do
  context 'version determination' do
    it 'uses a production version as a default' do
      create(:version, :production)
      create(:institution_program, :contains_harv)
      get(:index)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'accepts invalid version parameter and returns production data' do
      create(:version, :production)
      create(:institution_program, :contains_harv)
      get(:index, params: { version: 'invalid_data' })
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
      body = JSON.parse response.body
      expect(body['meta']['version']['number'].to_i).to eq(Version.current_production.number)
    end

    it 'accepts version number as a version parameter and returns preview data' do
      create(:version, :production)
      v = create(:version, :preview)
      create(:institution_program, :contains_harv, version: Version.current_preview.number)
      get(:index, params: { version: v.uuid })
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
      body = JSON.parse response.body
      expect(body['meta']['version']['number'].to_i).to eq(Version.current_preview.number)
    end
  end

  context 'autocomplete results' do
    it 'returns collection of matches' do
      create(:version, :production)
      2.times { create(:institution_program, :start_like_harv) }
      get(:autocomplete, params: { term: 'harv' })
      expect(InstitutionProgram.count).to eq(2)
    end

    it 'limits results to 6' do
      create(:version, :production)
      7.times { create(:institution_program, :start_like_harv) }
      get(:autocomplete, params: { term: 'harv' })
      expect(JSON.parse(response.body)['data'].count).to eq(6)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('autocomplete')
    end

    it 'returns empty collection on missing term parameter' do
      create(:version, :production)
      create(:institution_program, :start_like_harv)
      get(:autocomplete)
      expect(JSON.parse(response.body)['data'].count).to eq(0)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('autocomplete')
    end
  end

  context 'search results' do
    before(:each) do
      create(:version, :production)
      2.times { create(:institution_program, :in_nyc) }
      create(:institution_program, :in_chicago)
      create(:institution_program, :in_new_rochelle)
    end

    it 'search returns results' do
      get(:index)
      expect(JSON.parse(response.body)['data'].count).to eq(4)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'search returns results matching institution name' do
      get(:index, params: { name: 'chicago' })
      expect(JSON.parse(response.body)['data'].count).to eq(1)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'search returns results matching program name' do
      create(:institution_program, description: 'IT')
      get(:index, params: { name: 'IT' })
      expect(JSON.parse(response.body)['data'].count).to eq(1)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'search returns results matching program type name' do
      create(:institution_program, program_type: 'FLGT')
      get(:index, params: { type: 'FLGT' })
      expect(JSON.parse(response.body)['data'].count).to eq(1)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'search returns case-insensitive results' do
      get(:index, params: { name: 'CHICAGO' })
      expect(JSON.parse(response.body)['data'].count).to eq(1)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'search with space returns results' do
      get(:index, params: { name: 'New Roch' })
      expect(JSON.parse(response.body)['data'].count).to eq(1)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'filter by uppercase country returns results' do
      get(:index, params: { name: 'chicago', country: 'USA' })
      expect(JSON.parse(response.body)['data'].count).to eq(1)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'filter by lowercase country returns results' do
      get(:index, params: { name: 'chicago', country: 'usa' })
      expect(JSON.parse(response.body)['data'].count).to eq(1)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'filter by uppercase state returns results' do
      get(:index, params: { name: 'new', state: 'NY' })
      expect(JSON.parse(response.body)['data'].count).to eq(3)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'filters by preferred_provider' do
      create(:institution_program, preferred_provider: true)
      get(:index, params: { vet_tec_provider: true, preferred_provider: true })
      expect(JSON.parse(response.body)['data'].count).to eq(1)
    end

    it 'filter by lowercase state returns results' do
      get(:index, params: { name: 'new', state: 'ny' })
      expect(JSON.parse(response.body)['data'].count).to eq(3)
      expect(response.content_type).to eq('application/json')
      expect(response).to match_response_schema('institution_programs')
    end

    it 'has facet metadata' do
      get(:index, params: { name: 'chicago' })
      facets = JSON.parse(response.body)['meta']['facets']
      expect(facets['state']['il']).to eq(1)
      expect(facets['country'].count).to eq(1)
      expect(facets['country'][0]['name']).to eq('USA')
    end

    # it 'includes type search term in facets' do
    #   get(:index, params: { name: 'chicago', type: 'foreign' })
    #   facets = JSON.parse(response.body)['meta']['facets']

    #   binding.pry

    #   expect(facets['program_type']['foreign']).not_to be_nil
    #   expect(facets['program_type']['foreign']).to eq(0)
    # end

    it 'includes state search term in facets' do
      get(:index, params: { name: 'chicago', state: 'WY' })
      facets = JSON.parse(response.body)['meta']['facets']
      expect(facets['state']['wy']).not_to be_nil
      expect(facets['state']['wy']).to eq(0)
    end

  #   it 'includes country search term in facets' do
  #     get(:index, params: { name: 'chicago', country: 'france' })
  #     facets = JSON.parse(response.body)['meta']['facets']
  #     match = facets['country'].select { |c| c['name'] == 'FRANCE' }.first
  #     expect(match).not_to be nil
  #     expect(match['count']).to eq(0)
  #   end
  end

  # context 'category and type search results' do
  #   before(:each) do
  #     create(:version, :production)
  #     create(:institution, :in_nyc)
  #     create(:institution, :ca_employer)
  #   end

  #   it 'filters by employer category' do
  #     get(:index, params: { category: 'employer' })
  #     expect(JSON.parse(response.body)['data'].count).to eq(1)
  #     expect(response.content_type).to eq('application/json')
  #     expect(response).to match_response_schema('institutions')
  #   end

  #   it 'filters by school category' do
  #     get(:index, params: { category: 'school' })
  #     expect(JSON.parse(response.body)['data'].count).to eq(1)
  #     expect(response.content_type).to eq('application/json')
  #     expect(response).to match_response_schema('institutions')
  #   end

  #   it 'filters by employer type' do
  #     get(:index, params: { type: 'ojt' })
  #     expect(JSON.parse(response.body)['data'].count).to eq(1)
  #     expect(response.content_type).to eq('application/json')
  #     expect(response).to match_response_schema('institutions')
  #   end

  #   it 'filters by school type' do
  #     get(:index, params: { type: 'private' })
  #     expect(JSON.parse(response.body)['data'].count).to eq(1)
  #     expect(response.content_type).to eq('application/json')
  #     expect(response).to match_response_schema('institutions')
  #   end
  # end
end
