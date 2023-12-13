# frozen_string_literal: true

FactoryBot.define do
  factory :blog do
    association :topic
    title { "Blog title" }
    body { "Blog body" }
  end
end
