class Genre < ApplicationRecord
	has_many :reviews,dependent: :destroy
	vakidates :genre, presence: true
end
