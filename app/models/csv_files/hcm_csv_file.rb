class HcmCsvFile < CsvFile
  HEADER_MAP = {
    'institution name' => :institution,
    'ope id' => :ope,
    'stop pay/monitor method' => :hcm_type,
    'method reason desc' => :hcm_reason
  }.freeze

  SKIP_LINES_BEFORE_HEADER = 2
  SKIP_LINES_AFTER_HEADER = 0

  DISALLOWED_CHARS = /[^#%&'\w@:\- \.\/\(\)\+]/

  #############################################################################
  ## populate
  ## Reloads the accreditation table with the data in the csv data store
  #############################################################################
  def populate
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil

    begin
      write_data

      rc = true
    rescue StandardError => e
      errors[:base] << e.message
      rc = false
    ensure
      ActiveRecord::Base.logger = old_logger
    end

    rc
  end
end
