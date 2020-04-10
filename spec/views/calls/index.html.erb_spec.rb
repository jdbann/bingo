require 'rails_helper'

RSpec.describe "calls/index", type: :view do
  before(:each) do
    assign(:calls, [
      Call.create!(
        name: "Name",
        round: nil
      ),
      Call.create!(
        name: "Name",
        round: nil
      )
    ])
  end

  it "renders a list of calls" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
