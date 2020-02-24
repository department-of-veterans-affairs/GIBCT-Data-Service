# frozen_string_literal: true

class YellowRibbonProgramSourceSerializer < ActiveModel::Serializer
  attributes :city,
             :contribution_amount,
             :degree_level,
             :division_professional_school,
             :facility_code,
             :number_of_students,
             :school_name_in_yr_database,
             :state,
             :street_address,
             :zip
end
