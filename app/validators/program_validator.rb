# frozen_string_literal: true

class ProgramValidator < ActiveModel::Validator
  def self.non_unique_error_msg(record)
    "The Facility Code & Description (Program Name) combination is not unique:
#{record.facility_code}, #{record.description}"
  end

  def self.missing_facility_code_error_msg(record)
    "The Facility Code #{record.facility_code} is not contained within the most recently uploaded weams.csv"
  end

  def validate(record)
    if Program.where(['description = ? AND facility_code = ? AND id != ?',
                      record.description, record.facility_code, record.id]).any?
      record.errors[:base] << ProgramValidator.non_unique_error_msg(record)
    end

    return if Weam.where(['facility_code = ?', record.facility_code]).any?
    record.errors[:base] << ProgramValidator.missing_facility_code_error_msg(record)
  end
end
