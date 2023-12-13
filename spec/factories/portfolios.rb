# frozen_string_literal: true

FactoryBot.define do
  factory :portfolio do
    title { 'Portfolio title' }
    body { 'Portfolio body' }
    main_image { 'test_image.jpg' }
    thumb_image { 'test_image.jpg' }
  end
end
