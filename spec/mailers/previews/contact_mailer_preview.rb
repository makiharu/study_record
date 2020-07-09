# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact_mail
    contact = Contact.new(name: 'ほげお', email: 'hogeo@example.com', content: 'テストです')
    ContactMailer.contact_mail(contact)
  end
end
