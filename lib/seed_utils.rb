# frozen_string_literal: true

module SeedUtils
  extend self

  def seed_table_with_upload(klass, user, options = {})
    csv_name = "#{klass.name.underscore}.csv"
    csv_type = klass.name
    csv_path = 'sample_csvs'

    puts "Loading #{klass.name} from #{csv_path}/#{csv_name} ... "

    uf = ActionDispatch::Http::UploadedFile.new(
      tempfile: File.new(Rails.root.join(csv_path, csv_name)),
      filename: csv_name,
      type: 'text/csv'
    )

    upload = Upload.create(upload_file: uf, csv_type: csv_type, comment: 'Seeding', user: user)
    seed_table(klass, "#{csv_path}/#{csv_name}", options)
    upload.update(ok: true)

    puts "Loading #{klass.name} storage from #{csv_path}/#{csv_name} ... "
    uf.rewind

    Storage.create(upload_file: uf, csv_type: csv_type, comment: 'Seeding', user: user)

    puts 'Done!'
  end

  def seed_table(klass, path, options = {})
    klass.load(path, options)
  end
end
