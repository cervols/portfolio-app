FactoryBot.define do
  factory :user do
    name { "John" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { "password" }
  end
end
