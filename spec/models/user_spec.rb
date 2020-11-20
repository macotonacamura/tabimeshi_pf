require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  RSpec.describe User, type: :model do

  	it "姓、名、メール、パスワードがある場合、有効である"
  		user = User.new(
  			user_name: "hanako",
  			email: "hanako@gmail.com" ,
  			password: "oooooo",
  			)
  		expect(user).to be_valid
  	end

  	it "名前がなければ登録できない"
  		user = User.new(
  			user_name: nil,
  			email: "testsan@gmail.com",
  			password: "oooooo",
  			)
  		user.valid?
  		expect(user.errors[:user_name]).to include("can't be blank")
  	end



  	# it "メールアドレスがなければ登録できない"
  	# it "メールアドレスが重複していたら登録できない"
  	# it "パスワードがなければ登録できない"


end
