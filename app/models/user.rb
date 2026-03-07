class User < ApplicationRecord
  has_secure_password
  has_one_attached :user_image
end
