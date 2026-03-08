class User < ApplicationRecord
  has_secure_password
  has_one_attached :user_image

  has_many :rooms
  has_many :reservations
end
