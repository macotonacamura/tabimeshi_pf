require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
   before do
  	visit new_user_session_path
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'Log in'
  end
  describe '新規投稿のテスト' do
  	before do
      visit new_review_path
  		@review = FactoryBot.create(:review)
    end
		context '表示の確認' do
		  it 'レビューを投稿する と表示される' do
	    	expect(page).to have_content 'レビューを投稿する'
		  end
		  it '店名フォームが表示される' do
		  	expect(page).to have_field 'review[restaurant_name]'
		  end
		  it '国フォームが表示される' do
		  	expect(page).to have_field 'review[country]'
		  end
		  it '都市フォームが表示される' do
		  	expect(page).to have_field 'review[city]'
		  end
		  it '住所フォームが表示される' do
		  	expect(page).to have_field 'review[address]'
		  end
		  it '通貨フォームが表示される' do #詰まったところ
		  	page.has_select? 'currency', options: @review.currency
		  end
		  it '予算フォームが表示される(最低)' do
		  	expect(page).to have_field 'review[budget]'
		  end
		  it '予算フォームが表示される(最高)' do
		  	expect(page).to have_field 'review[maximum_budget]'
		  end
		  it 'レビューフォームが表示される' do
		  	expect(page).to have_field 'review[review]'
		  end
		  it 'ジャンルフォームが表示される' do #詰まったところ
		  	page.has_select? 'genre_name', options: @review.genre_id_change
		  end
		  it '投稿ボタンが表示される' do
		  	expect(page).to have_button '投稿する'
		  end
		  it '投稿に成功する' do #★
		  	fill_in 'review[restaurant_name]', with: @review.restaurant_name
		  	find('#review_star', visible: false).set(@review.rate)
		  	fill_in 'review[country]', with: @review.city.country
		  	fill_in 'review[city]', with: @review.city
		  	fill_in 'review[address]', with: @review.address
		  	select(value = "$", from: "review[currency]")
		  	fill_in 'review[maximum_budget]',with: @review.maximum_budget
		  	fill_in 'review[review]',with: @review.review
		  	select(value = @review.genre_id_change, from: "review[genre_id]")
		  	find('#review_review_images_attributes_0_image', visible: false).set(@review.review_images)
		  	click_button '投稿する'
		  	expect(page).to have_content 'さんの口コミ'
		  end
		  it '投稿に失敗する' do
		  	click_button '投稿する'
		  	expect(page).to have_content 'レビューを投稿する'
		  	expect(current_path).to eq('/reviews')
		  end
		 end
  end

end