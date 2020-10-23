class Review < ApplicationRecord

	belongs_to :user
	has_many :review_images, dependent: :destroy
  accepts_nested_attributes_for :review_images, allow_destroy: true

	validates :rate, numericality: {
  less_than_or_equal_to: 5,
  greater_than_or_equal_to: 1
	}, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

	validates :restaurant_name,  length: { maximum: 20 }
	validates :review,presence: true
	validates :rate, presence: true
	validates :budget, presence: true
	validates :muximum_budget, presence: true
	validates :address, presence: true
	validates :country, presence: true
	validates :city, presence: true





end
