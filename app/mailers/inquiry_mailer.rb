class InquiryMailer < ApplicationMailer

	def send_mail(inquiry)
	    @inquiry = inquiry
	    mail to: 'cmbcxxmc@gmail.com', subject: 'お問い合わせ通知'
    end

end
