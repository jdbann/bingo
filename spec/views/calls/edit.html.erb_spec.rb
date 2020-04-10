require 'rails_helper'

RSpec.describe "calls/edit", type: :view do
  before(:each) do
    @call = assign(:call, Call.create!(
      name: "MyString",
      round: nil
    ))
  end

  it "renders the edit call form" do
    render

    assert_select "form[action=?][method=?]", call_path(@call), "post" do

      assert_select "input[name=?]", "call[name]"

      assert_select "input[name=?]", "call[round_id]"
    end
  end
end
