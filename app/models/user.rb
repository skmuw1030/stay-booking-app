class User < ApplicationRecord
  has_secure_password
  has_one_attached :user_image

  has_many :rooms
  has_many :reservations

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
