require 'rails_helper'

RSpec.describe "calls/new", type: :view do
  before(:each) do
    assign(:call, Call.new(
      name: "MyString",
      round: nil
    ))
  end

  it "renders new call form" do
    render

    assert_select "form[action=?][method=?]", calls_path, "post" do

      assert_select "input[name=?]", "call[name]"

      assert_select "input[name=?]", "call[round_id]"
    end
  end
end
