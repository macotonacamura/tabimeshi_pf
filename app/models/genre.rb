class Genre < ApplicationRecord
	has_many :reviews,dependent: :destroy
end
