# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "John" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { "password" }
  end

  trait :site_admin do
    roles { :site_admin }
  end
end
