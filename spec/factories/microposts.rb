# frozen_string_literal: true

FactoryBot.define do
  factory :micropost do
    content { 'MyText' }
    association :user
  end
end
