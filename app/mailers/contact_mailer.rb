class ContactMailer < ApplicationMailer
	def contact_mail(contact)
	  @contact = contact
	  mail to:"makiharutest@gmail.com", subject: "問い合わせメールのお知らせ"
	end
end
