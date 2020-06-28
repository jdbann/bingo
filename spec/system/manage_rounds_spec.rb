require "rails_helper"

RSpec.describe "ManageRounds", type: :system do
  it "allows you to create rounds" do
    visit rounds_path
    click_on "New Round"
    fill_in "Name", with: "Test Round"
    fill_in "Header", with: "#ServoBingo"
    fill_in "Footer", with: "White cars: 0"
    click_on "Create Round"
    expect(page).to have_content("Test Round")
  end

  it "allows you to reset all calls" do
    round = Round.create(name: "Test Round")
    hidden_call = Call.create(
      name: "Hidden call",
      round: round,
      hidden: true
    )
    visible_call = Call.create(
      name: "Visible call",
      round: round,
      hidden: false
    )
    visit round_path(round)
    click_on "Reset calls"
    expect(hidden_call.reload).to be_hidden
    expect(visible_call.reload).to be_hidden
  end
end
