class Review < ApplicationRecord

	belongs_to :user

	has_many :likes , dependent: :destroy
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

	has_many :review_comments , dependent: :destroy
	belongs_to :genre

	belongs_to :city


	has_many :review_images, dependent: :destroy
  	accepts_nested_attributes_for :review_images, limit: 5

	geocoded_by :address
	after_validation :geocode, if: :address_changed?

	with_options presence: true do
		validates :restaurant_name, length: { maximum: 60 }
		validates :review
		validates :rate
		validates :budget, numericality: { only_integer: true, greater_than: 1}  #less_than: :maximum_budget
		validates :maximum_budget, numericality: { only_integer: true, greater_than: 1 }
		validates :address
		validates :city
		validates :rate, numericality: {
				   less_than_or_equal_to: 5,
		    	   greater_than_or_equal_to: 1
				  }
	end


	#自分でval作る
	validate :check_budget
    def check_budget
	    errors.add(:budget, "より大きい値にしてください") if !(self.budget < self.maximum_budget) #.errors：エラーメッセージ 作成
    end



end
