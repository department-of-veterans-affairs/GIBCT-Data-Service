# frozen_string_literal: true

module CsvHelper
  module Loader
    CSV_FIRST_LINE = 2

    SMARTER_CSV_OPTIONS = {
      force_utf8: true, remove_zero_values: false, remove_empty_hashes: true,
      remove_empty_values: true, convert_values_to_numeric: false, remove_unmapped_keys: true
    }.freeze

    def load(file, options = {})
      delete_all
      load_records(file, options)
    end

    private

    def load_records(file, options)
      records = { valid: [], invalid: [], all: [] }

      records = klass == Institution ? load_csv_with_version(file, records, options) : load_csv(file, records, options)
      results = klass.import records[:valid], validate: false, ignore: true
      run_validations(records, options)
      results.failed_instances = records[:invalid]
      results
    end

    def load_csv(file, records, options)
      SmarterCSV.process(file, merge_options(options)).each do |row|
        record = klass.new(row)
        save_record_to_records(records, record)
      end

      records
    end

    def load_csv_with_version(file, records, options)
      version = Version.current_preview

      SmarterCSV.process(file, merge_options(options)).each.with_index do |row, _i|
        record = klass.new(row.merge(version: version.number))
        save_record_to_records(records, record)
      end

      records
    end

    def save_record_to_records(records, record)
      record.errors.any? ? records[:invalid] << record : records[:valid] << record
      records[:all] << record
    end

    def merge_options(options)
      key_mapping = {}
      value_converters = {}

      klass::CSV_CONVERTER_INFO.each_pair do |csv_column, info|
        value_converters[info[:column]] = info[:converter]
        key_mapping[csv_column.tr(' -', '_').to_sym] = info[:column]
      end

      options.reverse_merge(key_mapping: key_mapping, value_converters: value_converters)
             .reverse_merge(SMARTER_CSV_OPTIONS)
    end

    # Running this after rows are inserted to validate against data in the table
    def run_validations(records, options)
      # Since row indexes start at 0 and spreadsheets on line 1,
      # add 1 for the difference in indexes and 1 for the header row itself.
      row_offset = CSV_FIRST_LINE + (options[:skip_lines] || 0)

      records[:all].each_with_index do |record, index|
        record.errors.add(:row, "Line #{index + row_offset}") unless record.valid?
        records[:invalid] << record if record.errors.any?
      end
    end
  end
end
