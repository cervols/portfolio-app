class Portfolio < ApplicationRecord
  has_many :technologies, dependent: :destroy

  acts_as_list

  accepts_nested_attributes_for :technologies,
                                allow_destroy: true,
                                reject_if: proc { |attrs| attrs['name'].blank? }

  validates_presence_of :title, :body

  scope :by_position, -> { order("position ASC") }

  mount_uploader :main_image, PortfolioUploader
  mount_uploader :thumb_image, PortfolioUploader
end
