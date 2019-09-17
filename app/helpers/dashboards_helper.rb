# frozen_string_literal: true

module DashboardsHelper
  def latest_upload_class(upload)
    return '' if upload.ok?
    return 'danger' if CSV_TYPES_REQUIRED_TABLE_NAMES.include?(upload.csv_type)
    'warning'
  end

  def latest_upload_title(upload)
    return '' if upload.ok?
    return 'Missing required upload' if CSV_TYPES_REQUIRED_TABLE_NAMES.include?(upload.csv_type)
    'Missing upload'
  end

  def generate_preview_confirm
    return 'Are you sure you want to create a new preview version?'
  end
end
