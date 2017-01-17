# frozen_string_literal: true
require 'rails_helper'
require 'models/shared_examples/shared_examples_for_loadable'
require 'models/shared_examples/shared_examples_for_exportable'

RSpec.describe Hcm, type: :model do
  it_behaves_like 'a loadable model', skip_lines: 2
  it_behaves_like 'an exportable model', skip_lines: 2

  describe 'when validating' do
    subject { build :hcm }

    it 'has a valid factory' do
      expect(subject).to be_valid
    end

    it 'requires the ope' do
      expect(build(:hcm, ope: nil)).not_to be_valid
    end

    it 'requires hcm_type' do
      expect(build(:hcm, hcm_type: nil)).not_to be_valid
    end

    it 'requires hcm_reason' do
      expect(build(:hcm, hcm_reason: nil)).not_to be_valid
    end
  end
end
