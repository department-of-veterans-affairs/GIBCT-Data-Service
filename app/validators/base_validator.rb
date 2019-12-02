# frozen_string_literal: true

class BaseValidator < ActiveModel::Validator
  def self.missing_facility_error_msg(record)
    "The Facility Code #{record.facility_code} is not contained within the most recently uploaded weams.csv"
  end

  private

  def facility_code_in_weam?(record)
    facility_not_in_weam = record.facility_code.present? &&
                           Weam.where(['facility_code = ?', record.facility_code]).empty?
    record.errors[:base] << missing_facility_error_msg(record) if facility_not_in_weam
  end
end
