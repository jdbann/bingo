require "rails_helper"

RSpec.describe Call, type: :model do
  it { is_expected.to belong_to :round }

  describe ".visile" do
    let(:round) { Round.create(name: "Test Round") }

    it "includes visible calls" do
      call = round.calls.create(name: "Test Call", hidden: false)
      expect(described_class.visible).to include call
    end

    it "excludes hidden calls" do
      call = round.calls.create(name: "Test Call", hidden: true)
      expect(described_class.visible).not_to include call
    end
  end
end
