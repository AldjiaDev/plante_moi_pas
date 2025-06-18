class PlantLog < ApplicationRecord
  belongs_to :plant

  validates :date, uniqueness: { scope: :plant_id }
end
