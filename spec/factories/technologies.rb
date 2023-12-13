# frozen_string_literal: true

FactoryBot.define do
  factory :technology do
    association :portfolio
    name { "Technology name" }
  end
end
