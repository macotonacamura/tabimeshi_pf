class Users::InquiriesController < ApplicationController

	def new
		@inquiry = Inquiry.new
	end

	def create
		@inquiry = Inquiry.new(inquiry_params)
		if @inquiry.save
			InquiryMailer.send_mail(@inquiry).deliver
			redirect_to reviews_path
		else
			redirect_to reviews_path
		end
	end

	private
	def inquiry_params
		params.require(:inquiry).permit(:name,:message)
	end

end
