require "rails_helper"

RSpec.describe "ManageCalls", type: :system do
  before do
    driven_by(:selenium_chrome)
  end

  it "allows you to create calls" do
    round = Round.create(name: "Test Round")
    visit round_path(round)
    click_on "New Call"
    fill_in "Name", with: "Red Ute"
    click_on "Create Call"
    expect(page).to have_content("Red Ute")
  end
end
