# frozen_string_literal: true

require 'rails_helper'
require 'support/controller_macros'
require 'support/devise'
require 'controllers/shared_examples/shared_examples_for_authentication'

RSpec.describe CalculatorConstantsController, type: :controller do
  describe 'GET #index' do
    login_user

    it 'returns calculator constants' do
      create_list(:calculator_constant, 2)
      get :index
      expect(assigns(:calculator_constants)).to eq(CalculatorConstant.all)
    end
  end

  describe 'POST #update' do
    login_user
    test_rate = 9999.99

    let(:params) do
      {
        AVGDODBAH: test_rate
      }
    end

    it 'updated calculator constants' do
      create :upload, :calculator_constant
      create :calculator_constant, :avg_dod_bah_constant
      post(:update, params: params)
      expect(CalculatorConstant.where(name: 'AVGDODBAH')[0].float_value).to eq(test_rate)
    end
  end
end