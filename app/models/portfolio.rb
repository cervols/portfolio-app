class Portfolio < ApplicationRecord
  has_many :technologies

  accepts_nested_attributes_for :technologies,
                                reject_if: proc { |attrs| attrs['name'].blank? }

  validates_presence_of :title, :body, :main_image, :thumb_image

  # TODO: remove after starting to utilize carrierwave gem
  after_initialize :set_defaults

  private

    def set_defaults
      self.main_image ||= 'http://placehold.it/600x400'
      self.thumb_image ||= 'http://placehold.it/350x200'
    end
end
