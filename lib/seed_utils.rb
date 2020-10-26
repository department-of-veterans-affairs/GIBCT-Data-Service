# frozen_string_literal: true

module SeedUtils
  module_function

  def seed_table_with_upload(klass, user, options = {})
    seed_options = Common::Shared.file_type_defaults(klass.name, options)
    file_options = { liberal_parsing: seed_options[:liberal_parsing],
                     sheets: [{ klass: klass, skip_lines: seed_options[:skip_lines].try(:to_i) }] }

    csv_type = klass.name
    csv_name = "#{csv_type.underscore}.csv"
    csv_path = 'sample_csvs'

    puts "Loading #{klass.name} from #{csv_path}/#{csv_name} ... "

    uf = ActionDispatch::Http::UploadedFile.new(
      tempfile: File.new(Rails.root.join(csv_path, csv_name)),
      # dup required until upgrade: https://github.com/rails/rails/commit/bfbbb1207930e7ebe56d4a99abd53b2aa66e0b6e
      filename: csv_name.dup,
      content_type: 'text/csv'
    )

    upload = Upload.create(upload_file: uf, csv_type: csv_type, comment: 'Seeding', user: user)
    seed_table(klass, "#{csv_path}/#{csv_name}", file_options)
    upload.update(ok: true)

    puts "Loading #{klass.name} storage from #{csv_path}/#{csv_name} ... "
    uf.rewind

    Storage.create(upload_file: uf, csv_type: csv_type, comment: 'Seeding', user: user)

    puts 'Done!'
  end

  def seed_table(klass, path, options = {})
    klass.load_with_roo(path, options)
  end
end
