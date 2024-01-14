# frozen_string_literal: true

FactoryBot.define do
  factory :portfolio do
    title { "Portfolio title" }
    body { "Portfolio body" }
    main_image { Rack::Test::UploadedFile.new(Rails.root.join("spec", "support", "files", "attachment.png")) }
    thumb_image { Rack::Test::UploadedFile.new(Rails.root.join("spec", "support", "files", "attachment.png")) }
  end

  trait :with_technology do
    after(:create) do |portfolio|
      create(:technology, portfolio: portfolio)
    end
  end
end
