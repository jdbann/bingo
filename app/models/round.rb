class Round < ApplicationRecord
  has_many :calls, dependent: :destroy
  has_many :cards, dependent: :destroy
end
