require "rails_helper"

RSpec.describe "ManageRounds", type: :system do
  before do
    driven_by(:selenium_chrome)
  end

  it "allows you to create rounds" do
    visit rounds_path
    click_on "New Round"
    fill_in "Name", with: "Test Round"
    click_on "Create Round"
    expect(page).to have_content("Test Round")
  end
end
