class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid? && not_a_robot?
      ContactMailer.contact_email(@contact).deliver_now

      redirect_to root_path, notice: t('flash.contacts.create')
    else
      flash.delete(:recaptcha_error)

      render 'new'
    end
  end

  private

  def not_a_robot?
    verify_recaptcha(model: @contact, attribute: :captcha)
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
