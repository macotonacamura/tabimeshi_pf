class ReviewImage < ApplicationRecord

	belongs_to :review, optional: true
	mount_uploader :image, ImageUploader

end
