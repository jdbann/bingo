require "rails_helper"

RSpec.describe Card, type: :model do
  it { is_expected.to belong_to(:round) }

  describe "callbacks" do
    it "creates a code" do
      round = Round.create(name: "Test Round")
      card = round.cards.new
      expect { card.save }.to change(card, :code)
    end

    it "does not override a specified code" do
      round = Round.create(name: "Test Round")
      card = round.cards.new(code: "horses")
      expect { card.save }.not_to change(card, :code)
    end
  end

  describe "#to_param" do
    it "returns code" do
      round = Round.create(name: "Test Round")
      card = round.cards.create
      expect(card.to_param).to eq card.code
    end
  end
end
