# require 'rails_helper'

# describe 'ユーザー認証のテスト' do
#   describe 'ユーザー新規登録' do
#     before do
#       visit new_user_registration_path
#     end
#     context '新規登録画面に遷移' do
#       it '新規登録に成功する' do
#         fill_in 'user[user_name]', with: FactoryBot.name.username(specifier: 5)
#         fill_in 'user[email]', with: FactoryBot.email
#         fill_in 'user[password]', with: 'password'
#         fill_in 'user[password_confirmation]', with: 'password'
#         click_button 'Sign up'

#         expect(page).to have_content 'successfully'
#       end
#       it '新規登録に失敗する' do
#         fill_in 'user[name]', with: ''
#         fill_in 'user[email]', with: ''
#         fill_in 'user[password]', with: ''
#         fill_in 'user[password_confirmation]', with: ''
#         click_button 'Sign up'

#         expect(page).to have_content 'error'
#       end
#     end
#   end
#   describe 'ユーザーログイン' do
#     let(:user) { create(:user) }
#     before do
#       visit new_user_session_path
#     end
#     context 'ログイン画面に遷移' do
#       let(:test_user) { user }
#       it 'ログインに成功する' do
#         fill_in 'user[name]', with: test_user.name
#         fill_in 'user[password]', with: test_user.password
#         click_button 'Log in'

#         expect(page).to have_content 'successfully'
#       end

#       it 'ログインに失敗する' do
#         fill_in 'user[name]', with: ''
#         fill_in 'user[password]', with: ''
#         click_button 'Log in'

#         expect(current_path).to eq(new_user_session_path)
#       end
#     end
#   end
# end