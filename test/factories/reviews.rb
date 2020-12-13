FactoryBot.define do
	factory :review do
		user{create(:user)}
		genre{create(:genre)}
		city{create(:city)}

		restaurant_name{"test_restaurant"}
		review {"美味しかった"}
		rate {"5"}
		budget{40}
		maximum_budget{100}
		currency{"$"}
		address{"Vancouver,Canada"}


		after(:build) do |build_review|
			build_review.review_images<<FactoryBot.build(:review_image)
		end
	end

	factory :review_image do
  		image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.jpg"), 'image/png') }
	end

	# factory :review2 do
	# 	user{create(:user2)}
	# 	genre{create(:genre)}
	# 	city{create(:city)}

	# 	restaurant_name{"test2_restaurant"}
	# 	review {"美味しかったです"}
	# 	rate {"5"}
	# 	budget{40}
	# 	maximum_budget{100}
	# 	currency{"$"}
	# 	address{"Tronto,Canada"}

	# 	after(:build) do |build_review|
	# 		build_review.review_images<<FactoryBot.build(:review_image)
	# 	end
	# end

	# factory :review_image do
 #  		image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.jpg"), 'image/png') }
	# end

end