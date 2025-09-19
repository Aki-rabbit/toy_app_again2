require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user){create(:user)}

  describe 'バリデーション' do
    it 'content が140文字以内なら有効' do
      micropost = build(:micropost, content: 'a' * 140, user: user)
      expect(micropost).to be_valid
    end

    it 'content が141文字以上だと無効' do
      micropost = build(:micropost, content: 'a' * 141, user: user)
      expect(micropost).not_to be_valid
    end

    it 'user が紐づいていないと無効' do
      micropost = build(:micropost, content: 'Valid content', user: nil)
      expect(micropost).not_to be_valid
    end
  end

  describe '関連付け' do
    it { is_expected.to belong_to(:user) }
  end
end
