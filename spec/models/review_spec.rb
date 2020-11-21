require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#create' do
	  before do
	      @user = FactoryBot.create(:user)
	  end

	  it "レストランの名前がなければ投稿できない" do
  		expect(FactoryBot.build(:review, restaurant_name: "")).to_not be_valid
  	  end

  	  it "評価がなければ登録できない" do
  		expect(FactoryBot.build(:review, rate: "")).to_not be_valid
  	  end

  	  it "住所がなければ登録できない" do
  		expect(FactoryBot.build(:review, address: "")).to_not be_valid
  	  end

  	  it "通貨がなければ登録できない" do
  		expect(FactoryBot.build(:review, currency: "")).to_not be_valid
  	  end

  	  it "min予算がなければ登録できない" do
  		expect(FactoryBot.build(:review, budget: 0)).to_not be_valid
  	  end

  	  it "max予算がなければ登録できない" do
  		expect(FactoryBot.build(:review, budget: 150, maximum_budget: 50)).to_not be_valid
  	  end

  	  it "口コミがなければ登録できない" do
  		expect(FactoryBot.build(:review, review: "")).to_not be_valid
  	  end

  	  it "ジャンルがなければ登録できない" do
  		expect(FactoryBot.build(:review, review: "")).to_not be_valid
  	  end

	  it "レビューの投稿写真がある" do
	      review = FactoryBot.build(:review)
	      review.valid?
	      expect(review).to be_valid
	  end

	end
end
