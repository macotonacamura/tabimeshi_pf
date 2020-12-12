require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[user_name]', with:Faker::Internet.username
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button 'Sign up'

        expect(page).to have_content 'マイページ'
      end
      it '新規登録に失敗する' do
        fill_in 'user[user_name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button 'Sign up'

        expect(page).to have_content 'error'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'Log in'

        expect(page).to have_content 'マイページ'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

#ここまでOK________

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:test_user2) { create(:user) }
  let!(:review) { create(:review, user: user) }
  before do #let(:user)↓before処理内で変数のような役割
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  describe 'ヘッダーのテスト' do
    context 'リンクの表示確認' do
      it 'ユーザー一覧と表示される' do
        expect(page).to have_content('ユーザー一覧')
      end
      it 'レビュー投稿と表示される' do
        expect(page).to have_content('レビュー投稿')
      end
      it 'マイページと表示される' do
        expect(page).to have_content('マイページ')
      end
      it '詳細ページへのリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link nil, href: "/ja" + user_path(user)
      end
      it '編集ページへのリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: "/ja" + edit_user_path(user)
      end
      it 'ログアウトのリンクが表示される' do #
        visit destroy_user_session_path
        expect(page).to have_link nil, href: destroy_user_session_path
      end
    end
  end


  describe '編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
    context '他人の編集画面への遷移' do
      it '遷移できない' do #
        visit edit_user_path(test_user2)
        expect(user_path(user)).to eq user_path(user)
      end
    end
    context '表示の確認' do
      before do
        visit edit_user_path(user)
      end
      it '登録情報編集と表示される' do
        expect(page).to have_content('登録情報編集')
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[user_name]', with: user.user_name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '自己紹介編集フォームに自分の自己紹介が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '編集に成功する' do
        click_button '更新'
        expect(user_path(user)).to eq user_path(user)
      end
      it '編集に失敗する' do
        fill_in 'user[user_name]', with: ''
        click_button '更新'
        expect(page).to have_content 'error'
        expect(edit_user_path(user)).to eq edit_user_path(user)
      end
    end
  end
  describe '一覧画面のテスト' do
    before do
      visit users_path
    end
    context '表示の確認' do
      it 'ユーザーを探すと表示される' do
        expect(page).to have_content('ユーザーを探す')
      end
      it '自分と他の人の画像が表示される' do
        expect(all('img').size).to eq(3)
      end
      it '自分と他の人の名前が表示される' do
        expect(page).to have_content user.user_name
        expect(page).to have_content test_user2.user_name
      end
      it 'ユーザー詳細ページへのリンクが表示される' do #★
        expect(page).to have_link user.user_name, href: user_path(user)
        expect(page).to have_link user.user_name, href: user_path(test_user2)
      end
    end
  end

  describe '詳細画面のテスト' do
    before do
      visit user_path(user)
    end
    context '表示の確認' do
      it 'ユーザーの名前が表示される' do
        expect(page).to have_content user.user_name
      end
      it 'レビュー一覧のレストラン名のリンク先が正しい' do #★
        expect(page).to have_link restaurant_name, href: review_path(review)
      end
      it '投稿一覧にレビュー内容が表示される' do
        expect(page).to have_content(review.review)
      end
    end
  end


end