class ContactMailer < ApplicationMailer
	def contact_mail(contact)
	  @contact = contact
	  mail to:"<%= ENV['USER_EMAIL'] %>", subject: "問い合わせメールのお知らせ"
	end
end
