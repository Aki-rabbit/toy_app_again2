require "rails_helper"

RSpec.describe User, type: :model do
    describe '関連付け' do
        it { is_expected.to have_many(:microposts) }
    end
end