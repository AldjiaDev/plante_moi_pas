class User < ApplicationRecord
  has_secure_password

  has_one :plant, dependent: :destroy
  has_many :user_achievements
  has_many :achievements, through: :user_achievements
end
