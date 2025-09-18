require "rails_helper"

Rspec.describe User, type: :model do
    it { is_expected.to validate_presence_of(:name) }
end