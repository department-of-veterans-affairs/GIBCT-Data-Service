# frozen_string_literal: true

#
# This should not have to be here but ruby is not loading this in config/initializers/roo_helper.rb
Dir["#{Rails.application.config.root}/lib/roo_helper/**/*.rb"].sort.each { |f| require(f) }

class GroupsController < ApplicationController
  def index
    @uploads = Upload.paginate(page: params[:page]).order(created_at: :desc)
  end

  def new
    @upload = Upload.from_group_type(params[:csv_type])
    @extensions = Settings.roo_upload.extensions.single.join(', ')

    return csv_requirements if @upload.csv_type_check?

    alert_and_log(@upload.errors.full_messages.join(', '))
    redirect_to dashboards_path
  end

  def create
    @upload = Upload.create(merged_params)
    begin
     data = load_file
     alert_messages(data)
     data_results = data[:results]

     @upload.update(ok: data_results.present? && data_results.ids.present?, completed_at: Time.now.utc.to_s(:db))
     error_msg = "There was no saved #{klass} data. Please check the file or \"Skip lines before header\"."
     raise(StandardError, error_msg) unless @upload.ok?

     redirect_to @upload
    rescue StandardError => e
      @upload = Upload.from_csv_type(merged_params[:csv_type])
      csv_requirements if @upload.csv_type_check?
      alert_and_log("Failed to upload #{original_filename}: #{e.message}\n#{e.backtrace[0]}", e)
      render :new
   end
  end

  def show
    @upload = Upload.find_by(id: params[:id])

    csv_requirements if @upload.present?
    return if @upload.present?

    alert_and_log("Upload with id: '#{params[:id]}' not found")
    redirect_to uploads_path
  end

  private

  def csv_requirements
    @requirements = requirements_messages
    @custom_batch_validator = "#{klass.name}Validator::REQUIREMENT_DESCRIPTIONS".safe_constantize
    @inclusion = validation_messages_inclusion
  end

  def alert_messages(data)
    results = data[:results]

    total_rows_count = results.ids.length
    failed_rows = results.failed_instances
    failed_rows_count = failed_rows.length
    valid_rows = total_rows_count - failed_rows_count
    validation_warnings = failed_rows.sort { |a, b| a.errors[:row].first.to_i <=> b.errors[:row].first.to_i }
                                     .map(&:display_errors_with_row)
    header_warnings = data[:header_warnings]

    if valid_rows.positive?
      flash[:csv_success] = {
        total_rows_count: total_rows_count.to_s,
        valid_rows: valid_rows.to_s,
        failed_rows_count: failed_rows_count.to_s
      }.compact
    end

    flash[:warning] = {
      'The following headers should be checked: ': (header_warnings unless header_warnings.empty?),
      'The following rows should be checked: ': (validation_warnings unless validation_warnings.empty?)
    }.compact
  end

  def alert_and_log(message, error = nil)
    Rails.logger.error message + error&.backtrace.to_s
    flash[:danger] = message
  end

  def original_filename
    @original_filename ||= upload_params[:upload_file].try(:original_filename)
  end

  def merged_params
    upload_params.merge(csv: original_filename, user: current_user)
  end

  def upload_params
    @upload_params ||= params.require(:upload).permit(:csv_type, :skip_lines, :upload_file, :comment)
  end

  def load_file
    return unless @upload.persisted?

    file = @upload.upload_file.tempfile

    CrosswalkIssue.delete_all if [Crosswalk, IpedsHd, Weam].include?(klass)

    # first is used because when called from standard upload process
    # because only a single set of results is returned
    file_options = { liberal_parsing: @upload.liberal_parsing,
                     sheets: [{ klass: klass, skip_lines: @upload.skip_lines.try(:to_i) }] }
    data = klass.load_with_roo(file, file_options).first

    CrosswalkIssue.rebuild if [Crosswalk, IpedsHd, Weam].include?(klass)

    data
  end

  def klass
    @upload.csv_type.constantize
  end

  def requirements_messages
    [RooHelper.valid_col_seps]
      .push(validation_messages_presence)
      .push(validation_messages_numericality)
      .push(validation_messages_uniqueness)
      .compact
  end

  def klass_validator(validation_class)
    klass.validators.map do |validations|
      affected_attributes(validations) if validation_class == validations.class
    end.flatten.compact
  end

  def validation_messages_presence
    presence = { message: 'These columns must have a value: ', value: [] }

    presence[:value] = klass_validator(ActiveRecord::Validations::PresenceValidator)
    presence unless presence[:value].empty?
  end

  def validation_messages_numericality
    numericality = { message: 'These columns can only contain numeric values: ', value: [] }

    numericality[:value] = klass_validator(ActiveModel::Validations::NumericalityValidator)

    numericality unless numericality[:value].empty?
  end

  def validation_messages_uniqueness
    uniqueness = { message: 'These columns should contain unique values: ', value: [] }

    uniqueness[:value] = klass_validator(ActiveRecord::Validations::UniquenessValidator)

    uniqueness unless uniqueness[:value].empty?
  end

  def validation_messages_inclusion
    inclusion = []

    klass.validators.map do |validations|
      next unless validations.class == ActiveModel::Validations::InclusionValidator

      array = { message: affected_attributes(validations).join(', '),
                value: inclusion_requirement_message(validations) }
      inclusion.push(array)
    end
    inclusion unless inclusion.empty?
  end

  def affected_attributes(validations)
    validations.attributes
               .map { |column| csv_column_name(column).to_s }
               .select(&:present?) # derive_dependent_columns or columns not in CSV_CONVERTER_INFO will be blank
  end

  def csv_column_name(column)
    name = klass::CSV_CONVERTER_INFO.select { |_k, v| v[:column] == column }.keys.join(', ')
    Common::Shared.display_csv_header(name)
  end

  def inclusion_requirement_message(validations)
    validations.options[:in].map(&:to_s)
  end
end
