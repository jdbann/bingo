require "rails_helper"

RSpec.describe "ManageCalls", type: :system do
  it "allows you to create calls" do
    round = Round.create(name: "Test Round")
    visit admin_round_path(round)
    click_on "New Call"
    fill_in "Name", with: "Red Ute"
    click_on "Create Call"
    expect(page).to have_content("Red Ute")
  end

  it "shows calls on round source screen" do
    round = Round.create(name: "Test Round")
    Call.create(name: "Red Ute", round: round, hidden: false)
    visit screen_admin_round_path(round)
    wait_for_connection
    expect(page).to have_content("Red Ute")
  end

  it "doesn't add new calls to source screen automatically" do
    round = Round.create(name: "Test Round")
    visit admin_round_path(round)

    using_session "screen" do
      visit screen_admin_round_path(round)
      wait_for_connection
      expect(page).not_to have_content "Red Ute"
    end

    click_on "New Call"
    fill_in "Name", with: "Red Ute"
    click_on "Create Call"

    using_session "screen" do
      expect(page).not_to have_content "Red Ute"
    end
  end

  it "can show and hide calls" do
    round = Round.create(name: "Test Round")
    call = Call.create(name: "Red Ute", round: round)
    visit admin_round_path(round)

    using_session "screen" do
      visit screen_admin_round_path(round)
      wait_for_connection
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

  def wait_for_connection
    page.has_no_content?("Connecting")
  end
end
