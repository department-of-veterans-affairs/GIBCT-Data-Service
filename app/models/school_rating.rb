# frozen_string_literal: true

class SchoolRating < ApplicationRecord
  include CsvHelper

  CSV_CONVERTER_INFO = {
    'ranker id' => { column: :ranker_id, converter: BaseConverter },
    'facility code' => { column: :facility_code, converter: FacilityCodeConverter },
    'overall experience' => { column: :overall_experience, converter: RankingConverter },
    'quality of classes' => { column: :quality_of_classes, converter: RankingConverter },
    'online instruction' => { column: :online_instruction, converter: RankingConverter },
    'job preparation' => { column: :job_preparation, converter: RankingConverter },
    'gi bill support' => { column: :gi_bill_support, converter: RankingConverter },
    'veteran community' => { column: :veteran_community, converter: RankingConverter },
    'marketing practices' => { column: :marketing_practices, converter: RankingConverter },
    'ranked on' => { column: :ranked_on, converter: DateTimeConverter }
  }.freeze

  validates :facility_code, :ranker_id, :ranked_on, presence: true
end
