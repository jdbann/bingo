class Card < ApplicationRecord
  belongs_to :round

  before_save :generate_code

  private

  def generate_code
    self.code ||= SecureRandom.base36(8)
  end
end
