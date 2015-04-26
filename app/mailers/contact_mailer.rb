class ContactMailer < ActionMailer::Base
  include MailerConcern

  def contact_email(contact)
    @contact = contact

    mail(
      to: Rails.application.config.contacts_destination,
      subject: t('mailers.contact.subject', name: @contact.name)
    )
  end
end
