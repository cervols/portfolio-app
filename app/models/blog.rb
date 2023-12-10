# frozen_string_literal: true

class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  DRAFT = 'draft'
  PUBLISHED = 'published'

  enum status: {
    DRAFT => 0,
    PUBLISHED => 1
  }

  validates_presence_of :title, :body
end
