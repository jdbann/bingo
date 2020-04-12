class Call < ApplicationRecord
  belongs_to :round

  scope :visible, -> { where(hidden: false) }
end
