require "rails_helper"

RSpec.describe "ManageCards", type: :system do
  it "allows you to generate a card" do
    round = Round.create(name: "Test Round")
    Call.create(name: "Test Call", round: round)
    visit admin_round_path(round)
    click_on "Cards"
    click_on "+ New Card"
    expect(page).to have_content(Card.last.code)
  end
end
