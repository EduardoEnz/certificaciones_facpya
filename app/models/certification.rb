class Certification < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :leads, through: :enrollments

  scope :active, -> { where(status: true) }
  scope :by_category, ->(cat) { where(category: cat) if cat.present? }

  validates :title, presence: true

  before_validation :generate_slug

  def to_param
    slug
  end
  def self.ransackable_attributes(auth_object = nil)
    ["category", "created_at", "description", "duration", "id", "modality", "price", "seats_available", "slug", "start_date", "status", "syllabus", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["enrollments", "leads"]
  end

  private

  def generate_slug
    self.slug ||= title&.downcase
      &.gsub(/[^a-z0-9\s]/, "")
      &.gsub(/\s+/, "-")
  end
end