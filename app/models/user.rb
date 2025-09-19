# frozen_string_literal: true

# Model for users
class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
end
