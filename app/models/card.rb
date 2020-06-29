class Card < ApplicationRecord
  belongs_to :round
  has_many :card_calls, dependent: :destroy
  has_many :calls, through: :card_calls

  before_save :generate_code, :select_card_calls

  def to_param
    code
  end

  private

  def generate_code
    self.code ||= SecureRandom.base36(8)
  end

  def select_card_calls
    self.calls = round.calls.sample(9)
  end
end
