# frozen_string_literal: true
RSpec.shared_examples 'an exportable model' do |options|
  let(:name) { described_class.name.underscore }
  let(:factory_name) { name.to_sym }
  let(:csv_file) { File.new(Rails.root.join('spec/fixtures', "#{name}.csv")) }
  let(:mapping) { described_class::MAP }

  subject { described_class.export }

  describe "#{described_class}::MAP" do
    it 'must be defined for exportable classes' do
      expect(mapping).not_to be_nil
    end
  end

  describe "#{described_class}.export" do
    before(:each) do
      described_class.load(csv_file, options)
    end

    it 'creates a string representation of a csv_file' do
      rows = subject.split("\n")
      header_row = rows.shift.split(',').map(&:downcase)

      rows = CSV.parse(rows.join("\n"))

      described_class.find_each.with_index do |record, i|
        attributes = {}

        rows[i].each.with_index { |value, j| attributes[mapping[header_row[j]][:column]] = value }
        csv_record = described_class.new(attributes)
        csv_record.derive_dependent_columns if csv_record.respond_to?(:derive_dependent_columns)

        csv_test_attributes = csv_record.attributes.except('id', 'created_at', 'updated_at')
        test_attributes = record.attributes.except('id', 'created_at', 'updated_at')

        expect(csv_test_attributes).to eq(test_attributes)
      end
    end
  end
end
