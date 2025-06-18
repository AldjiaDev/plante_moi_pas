class PlantLog < ApplicationRecord
  belongs_to :plant
  belongs_to :quest, optional: true
end
