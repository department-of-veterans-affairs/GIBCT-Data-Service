# frozen_string_literal: true

class CautionFlag < ApplicationRecord
  belongs_to :institution
  SOURCES = {
    accreditation_action: 'accreditation_action',
    mou: 'mou',
    sec_702: 'sec_702',
    settlement: 'settlement',
    hcm: 'hcm'
  }.freeze
end
