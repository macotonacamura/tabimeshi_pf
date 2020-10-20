class Review < ApplicationRecord

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :review_images, dependent: :destroy
  	accepts_nested_attributes_for :review_images, allow_destroy: true
end
