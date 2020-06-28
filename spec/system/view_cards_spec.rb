require "rails_helper"

RSpec.describe "ViewCards", type: :system do
  it "allows a player to view a card" do
    round = Round.create(name: "Test Round")
    card = round.cards.create
    visit cards_path
    fill_in "Code", with: card.code
    click_on "Play"
    expect(page).to have_content card.code
  end
end
