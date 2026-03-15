class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1, message: "は1円以上の数字で入力してください" }
  validates :address, presence: true
end
