class Review < ApplicationRecord

	belongs_to :user

	has_many :likes , dependent: :destroy
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

	has_many :review_comments , dependent: :destroy


	has_many :review_images, dependent: :destroy
  	accepts_nested_attributes_for :review_images, allow_destroy: true, limit: 4

	validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
	}, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

	validates :restaurant_name,  length: { maximum: 20 }
	validates :review,presence: true
	validates :rate, presence: true
	validates :budget, numericality: { only_integer: true,greater_than: 1,less_than: :muximum_budget}
	validates :muximum_budget, numericality: { only_integer: true,greater_than: :budget }
	validates :address, presence: true
	validates :country, presence: true
	validates :city, presence: true



end
