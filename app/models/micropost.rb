# frozen_string_literal: true

# Model for microposts
class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 140 }
end
