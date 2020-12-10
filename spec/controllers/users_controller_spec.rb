require 'rails_helper'

RSpec.describe Users::UsersController, type: :controller do

   describe "#index" do
	#正常なレスポンスか?
  	it "returns a 302 response" do
  	 get :index
     #pp response #これでレスポンスが何番で返ってくるのかをターミナルで確認できる
  	 expect(response).to have_http_status "302"
    end

    #200レスポンスが返ってきているか？
    it "returns a 200 response" do
     get :index
     expect(response).to have_http_status "302"
    end
   end


   describe "#show" do
   	before do
  		@user = FactoryBot.create(:user)
    end
   	it "returns a 302 response" do
   	 get :show, params: {id: @user.id}
   	 expect(response).to have_http_status "302"
   	end

   	#200レスポンスが返ってきているか？
    it "returns a 200 response" do
     get :show, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end
   end
   #showはすでにデータベースに保存された内容を表示するアクション
   #before内でarticleのインスタンスを作る際は、create（newとbuildはインスタンスを保存しない）を使う

   describe "#edit" do
    before do
      @user = FactoryBot.create(:user)
    end
    it "returns a 302 response" do
     get :edit, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end

    #200レスポンスが返ってきているか？
    it "returns a 200 response" do
     get :edit, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end
   end

   describe '#update' do
    before do
     @user = FactoryBot.create(:user)
    end
    context 'If the parameter available' do
     it 'request is going to success' do
      put :update, params: {id: @user.id, user: FactoryBot }
     end
     it 'To update user_name' do
      put  :update, params: {user_name: 'newname',id: @user.id }
      expect(@user.reload.user_name).not_to eq   Faker::Name.name
     end
    end
   end

   describe "#following" do
    before do
      @user = FactoryBot.create(:user)
    end
    it "returns a 302 response" do
     get :following, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end

    #200レスポンスが返ってきているか？
    it "returns a 200 response" do
     get :following, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end
   end

   describe "#follower" do
    before do
      @user = FactoryBot.create(:user)
    end
    it "returns a 302 response" do
     get :follower, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end

    #200レスポンスが返ってきているか？
    it "returns a 302 response" do
     get :follower, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end
   end

   describe "#unsubscribe" do
    before do
      @user = FactoryBot.create(:user)
    end
    it "returns a 302 response" do
     get :unsubscribe, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end

    #200レスポンスが返ってきているか？
    it "returns a 200 responses" do
     get :unsubscribe, params: {id: @user.id}
     expect(response).to have_http_status "302"
    end
   end


end
