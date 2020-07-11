class ContactsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to user_path(current_user), notice: 'メールの送信が完了しました'
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end

