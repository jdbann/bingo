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

  it "shows calls on round source screen" do
    round = Round.create(name: "Test Round")
    Call.create(name: "Red Ute", round: round)
    visit screen_round_path(round)
    expect(page).to have_content("Red Ute")
  end

  it "adds new calls to source screen automatically" do
    round = Round.create(name: "Test Round")
    visit round_path(round)

    using_session "screen" do
      visit screen_round_path(round)
      expect(page).not_to have_content "Red Ute"
    end

    click_on "New Call"
    fill_in "Name", with: "Red Ute"
    click_on "Create Call"

    using_session "screen" do
      expect(page).to have_content "Red Ute"
    end
  end

  it "can show and hide calls" do
    round = Round.create(name: "Test Round")
    call = Call.create(name: "Red Ute", round: round)
    visit round_path(round)

    using_session "screen" do
      visit screen_round_path(round)
      expect(page).not_to have_content "Red Ute"
    end

    within "#call-#{call.id}" do
      click_on "Show"
    end

    using_session "screen" do
      expect(page).to have_content "Red Ute"
    end

    within "#call-#{call.id}" do
      click_on "Hide"
    end

    using_session "screen" do
      expect(page).not_to have_content "Red Ute"
    end
  end
end
