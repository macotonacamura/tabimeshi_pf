class ReviewImage < ApplicationRecord

	belongs_to :review, optional: true
	attachment :image
	mount_uploader :image, ImageUploader
end
