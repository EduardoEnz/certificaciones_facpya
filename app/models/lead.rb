class Lead < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :certifications, through: :enrollments

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # --- Agrega esto para ActiveAdmin / Ransack ---
  def self.ransackable_attributes(auth_object = nil)
    ["career", "created_at", "email", "id", "name", "notes", "phone", "status", "student_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["certifications", "enrollments"]
  end
end