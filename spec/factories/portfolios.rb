# frozen_string_literal: true

FactoryBot.define do
  factory :portfolio do
    title { "Portfolio title" }
    body { "Portfolio body" }
  end

  trait :with_technology do
    after(:create) do |portfolio|
      create(:technology, portfolio: portfolio)
    end
  end
end
