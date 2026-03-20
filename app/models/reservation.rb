class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def stay_days
    (check_out - check_in).to_i
  end

  def total_price
    stay_days * room.price * number_of_people
  end

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :number_of_people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, message: "は1人以上の数字で入力してください" }

  validate :check_in_today_or_future

  private

  def check_in_today_or_future
    return if check_in.blank?
    if check_in < Date.today
      errors.add(:check_in, "はチェックイン日より後の日付にしてください")
    end
  end

  validate :check_out_after_check_in

  private

  def check_out_after_check_in
    return if check_in.blank? || check_out.blank?
    if check_out < check_in
      errors.add(:check_out, "はチェックイン日より後の日付にしてください")
    end
  end
end
