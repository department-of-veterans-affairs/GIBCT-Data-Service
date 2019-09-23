# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/shared_examples_for_loadable'
require 'models/shared_examples/shared_examples_for_exportable'

RSpec.describe Program, type: :model do
  it_behaves_like 'a loadable model', skip_lines: 0
  it_behaves_like 'an exportable model', skip_lines: 0

  describe 'when validating' do
    subject { build :program }

    it 'has a valid factory' do
      expect(subject).to be_valid
    end

    it 'requires a valid facility_code' do
      expect(build(:program, facility_code: nil)).not_to be_valid
    end

    it 'requires a valid program_type' do
      expect(build(:program, program_type: 'NCD')).to be_valid
    end
  end

  describe 'when validating for load_csv context' do
    it 'has no errors' do
      program = create :program

      expect(program).to be_valid
    end

    it 'has invalid facility code & description error message' do
      program = create :program
      program_2 = create :program, facility_code: program.facility_code

      expect(program.valid?(:load_csv)).to eq(false)
      expect(program_2.valid?(:load_csv)).to eq(false)

      error_messages = program.errors.messages
      expect(error_messages.any?).to eq(true)

      error_message = "The Facility Code & Description (Program Name) combination is not unique:
#{program.facility_code}, #{program.description}"
      expect(error_messages[:base]).to include(error_message)
    end

    it 'has invalid facility code error message' do
      program = create :program, facility_code: 00

      expect(program.valid?(:load_csv)).to eq(false)

      error_messages = program.errors.messages
      expect(error_messages.any?).to eq(true)

      error_message = "The Facility Code #{program.facility_code} is not contained within the most recently uploaded weams.csv"

      expect(error_messages[:base]).to include(error_message)
    end
  end
end
