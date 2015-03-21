class ContactsController < ApplicationController
  skip_after_action :verify_authorized

  def new
    @contact = Contact.new(user: current_user)
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user

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
    if @contact.guest?
      verify_recaptcha(model: @contact, attribute: :captcha)
    else
      true
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
