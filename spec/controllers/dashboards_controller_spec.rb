# frozen_string_literal: true
require 'rails_helper'
require 'support/controller_macros'
require 'support/devise'
require 'controllers/shared_examples/shared_examples_for_authentication'

RSpec.describe DashboardsController, type: :controller do
  it_behaves_like 'an authenticating controller', :index, 'dashboards'

  describe 'GET #index' do
    login_user

    before(:each) do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
