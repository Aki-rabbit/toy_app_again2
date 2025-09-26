# frozen_string_literal: true

RSpec.describe 'microposts/index', type: :view do
  let(:user) { create(:user, name: 'Bob') }

  before do
    assign(:microposts, create_list(:micropost, 2, content: 'MyText', user: user))
  end

  it 'renders a list of microposts' do
    render
    cell_selector = 'div>p'

    # コンテンツが2件分表示されること
    assert_select cell_selector, text: /MyText/, count: 2
  end
end
