class Portfolio < ApplicationRecord
  has_many :technologies

  validates_presence_of :title, :body, :main_image, :thumb_image
end
