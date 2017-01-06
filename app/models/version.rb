# frozen_string_literal: true
class Version < ActiveRecord::Base
  belongs_to :user, inverse_of: :versions

  validates_associated :user
  validates :user_id, presence: true

  before_validation :check_version
  before_save :increment_version

  scope :production, -> { where(production: true) }
  scope :preview, -> { where(production: false) }

  scope :max_by_time, -> { order(:created_at).last }

  def self.production_version
    Version.production.max_by_time
  end

  def self.preview_version
    Version.preview.max_by_time
  end

  def self.production_version_by_time(time)
    time = Time.zone.parse(time).to_datetime if time.is_a?(String)
    Version.production.where('created_at <= ?', time).max_by_time
  end

  def self.preview_version_by_time(time)
    time = Time.zone.parse(time).to_datetime if time.is_a?(String)
    Version.preview.where('created_at <= ?', time).max_by_time
  end

  def check_version
    if version.present? && Version.find_by(version: version).nil?
      errors.add(:version, "#{version} doesn't exist")
    end

    true
  end

  def increment_version
    self.version = (Version.maximum(:version) || 0) + 1 if version.nil?
  end
end
