require 'rails_helper'

RSpec.describe User, type: :model do
  	before do
  		@user = build(:user)
  	end

  	it "姓、名、メール、パスワードがある場合、有効である" do
  		expect(FactoryBot.create(:user)).to be_valid
  	end

  	it "名前がなければ登録できない" do
  		expect(FactoryBot.build(:user, user_name: "")).to_not be_valid
  	end

  	it "メールアドレスがなければ登録できない" do
  		expect(FactoryBot.build(:user, email: "")).to_not be_valid
  	end

  	it "メールアドレスが重複していたら登録できない" do
  		user1 = FactoryBot.create(:user,user_name: "taro", email: "taro@example.com")
    	expect(FactoryBot.build(:user, user_name: "ziro", email: user1.email)).to_not be_valid
    end

    it "パスワードがなければ登録できない" do
    	expect(FactoryBot.build(:user, password: "")).to_not be_valid
  	end

  	it "パスワードが暗号化されているか" do
    	user = FactoryBot.create(:user)
    	expect(user.password).to_not eq "password" #to_not eq = unequal
  	end

  	it "password_confirmationとpasswordが異なる場合保存できない" do
   		expect(FactoryBot.build(:user,password:"password",password_confirmation: "passward")).to_not be_valid #isn't valid
  	end


end
