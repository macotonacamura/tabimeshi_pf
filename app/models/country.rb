class Country < ApplicationRecord
	belongs_to :review, optional: true
end
