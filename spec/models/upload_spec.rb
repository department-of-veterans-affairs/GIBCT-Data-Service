# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Upload, type: :model do
  subject { build :upload }

  describe 'when validating' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end

    it 'requires the requesting user' do
      expect(build(:upload, user: nil)).not_to be_valid
    end

    it 'requires an upload_file to produce a filename' do
      expect(build(:upload, no_upload: true)).not_to be_valid
    end

    it 'requires a csv_type' do
      expect(build(:upload, csv_type: nil)).not_to be_valid
    end

    it 'defaults to !ok' do
      expect(build(:upload, csv_type: nil).ok).to be_falsey
    end

    it 'initializes csv column when not persisted' do
      expect(subject.csv).not_to be_blank

      subject.save
      expect(Upload.first.csv).not_to be_nil
    end
  end

  describe 'last_uploads' do
    before(:each) do
      # 3 Weam upload records
      create_list :upload, 3
      Upload.all[1].update(ok: true)

      create_list :upload, 3, csv_name: 'crosswalk.csv', csv_type: 'Crosswalk'
      Upload.where(csv_type: 'Crosswalk')[1].update(ok: true)
    end

    it 'gets the latest upload for each csv_type' do
      expect(Upload.last_uploads.length).to eq(2)
    end

    it 'gets only the latest upload for each csv_type' do
      max_weam = Upload.find_by(csv_type: 'Weam', ok: true)
      max_crosswalk = Upload.find_by(csv_type: 'Crosswalk', ok: true)
      uploads = Upload.last_uploads

      expect(uploads.where(csv_type: 'Weam').first).to eq(max_weam)
      expect(uploads.where(csv_type: 'Crosswalk').first).to eq(max_crosswalk)
    end
  end
end
