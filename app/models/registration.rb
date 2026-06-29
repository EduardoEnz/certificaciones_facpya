class Registration < ApplicationRecord
  belongs_to :event

  validates :name, :email, :phone, :role, presence: true
  validates :role, inclusion: { in: %w[Alumno Maestro], message: "%{value} no es un rol válido" }
  validates :matricula, :career, presence: true, if: :alumno?

  def alumno?
    role == 'Alumno'
  end

  # --- Reglas de seguridad para ActiveAdmin (Ransack) ---
  def self.ransackable_attributes(auth_object = nil)
    ["career", "created_at", "email", "event_id", "faculty", "id", "is_uanl", "matricula", "name", "phone", "role", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["event"]
  end
end