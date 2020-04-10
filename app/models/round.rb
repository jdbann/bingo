class Round < ApplicationRecord
  has_many :calls, dependent: :destroy
end
