require "rails_helper"

RSpec.describe User, type: :model do
    it "名前を入力しないと無効であること" do
        user = build(:user, name: nil)
        expect(user).to be_invalid
        expect(user.errors[:name]).to be_present
    end
end