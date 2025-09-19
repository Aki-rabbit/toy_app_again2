require 'rails_helper'

RSpec.describe "microposts/show", type: :view do
  let(:user) { create(:user, name: "Bob") }

  before(:each) do
    assign(:micropost, create(:micropost, content: "MyText", user: user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
