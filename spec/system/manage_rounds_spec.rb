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
end
