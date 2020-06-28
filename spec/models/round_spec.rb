require "rails_helper"

RSpec.describe Round, type: :model do
  it { is_expected.to have_many(:calls).dependent(:destroy) }
  it { is_expected.to have_many(:cards).dependent(:destroy) }
end
