# frozen_string_literal: true

require 'roo_helper/shared'

class CensusLatLong
  include RooHelper

  # Creates a ZIP file of CSVs by combining results from:
  #
  # - Approved Weams rows with physical city and physical state that meets one of these conditions:
  #   - does not have an ipeds_hd or scorecard
  #   - has ipeds_hd row but either physical city, physical state, or institution name does not match
  #   - has scorecard row but either physical city, or physical state does not match
  #
  # - Approved Weams rows without physical city and physical state that meets one of these conditions:
  #   - has ipeds_hd row but either city, or state does not match
  #   - has scorecard row but either city, or state does not match
  #   - if the facility code is present in the result set above it is ignored
  #
  # - Approved Institutions rows from latest version that do not have a latitude or longitude
  #   - if the facility code is present in either of the results sets above it is ignored
  def self.export
    missing_lat_long_physical_weams = Weam.missing_lat_long_physical
    missing_lat_long_mailing_weams = Weam.missing_lat_long_mailing

    weams_physical_facility_codes = missing_lat_long_physical_weams.map { |weam| weam.facility_code }.uniq
    weams_mailing_facility_codes = missing_lat_long_mailing_weams.map { |weam| weam.facility_code }.uniq
    weams_facility_codes = weams_physical_facility_codes + weams_mailing_facility_codes.uniq

    addresses = []
    Institution.missing_lat_long(Version.latest).each do |institution|
      next if weams_facility_codes.include?(institution.facility_code)

      value = [institution.physical_address || institution.address,
                    institution.physical_city || institution.city,
                    institution.physical_state || institution.state,
                    institution.physical_zip || institution.zip]

      addresses << value.unshift(institution.facility_code) if value.compact.count > 0

    end

    missing_lat_long_physical_weams.each do |weam|
      value = [weam.physical_address,
                    weam.physical_city,
                    weam.physical_state,
                    weam.physical_zip]

      addresses << value.unshift(weam.facility_code) if value.compact.count > 0
    end

    missing_lat_long_mailing_weams.each do |weam|
      next if weams_physical_facility_codes.include?(weam.facility_code)
      value = [weam.address,
                    weam.city,
                    weam.state,
                    weam.zip]

      addresses << value.unshift(weam.facility_code) if value.compact.count > 0
    end

    csvs = []
    addresses.compact.in_groups_of(10_000, false) do |batch|
      csvs << generate_csv(batch)
    end

    Group.export_csvs_as_zip(csvs, name)
  end
end
