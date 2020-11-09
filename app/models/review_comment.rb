class ReviewComment < ApplicationRecord
	belongs_to :user
	belongs_to :review

	validates :review_comment, presence: true,length: { maximum: 50 }
end
