class Event < ApplicationRecord
  has_many :registrations, dependent: :destroy

  validates :title, :capacity, :start_date, :end_date, presence: true
  validates :capacity, numericality: { greater_than: 0 }

  def full?
    registrations.count >= capacity
  end

  def registration_open?
    Time.current.between?(start_date, end_date)
  end

  # --- Reglas de seguridad para ActiveAdmin (Ransack) ---
  def self.ransackable_attributes(auth_object = nil)
    ["capacity", "created_at", "description", "end_date", "id", "start_date", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["registrations"]
  end
end