require "rails_helper"

RSpec.describe CardCall, type: :model do
  it { is_expected.to belong_to(:card) }
  it { is_expected.to belong_to(:call) }
end
