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

  validate :verify_date

  private

  def verify_date
    return if check_in.blank?
    if check_in < Date.today
      errors.add(:check_in, "は本日以降の日付を選択してください")
    end
  end


  validate :date_check

  private

  def date_check
    return if check_in.blank? || check_out.blank?
    if check_out < check_in
      errors.add(:check_out, "はチェックイン日より後の日付にしてください")
    end
  end
end
