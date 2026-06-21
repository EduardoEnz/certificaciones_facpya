class Enrollment < ApplicationRecord
  belongs_to :lead
  belongs_to :certification

  validates :lead_id, uniqueness: { scope: :certification_id }
end