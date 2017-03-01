class ContactMailer < ActionMailer::Base
  helper 'application'
  layout 'mailer'
  default from: "#{Rails.application.config.app_name} "\
    "<#{Rails.application.config.default_from}>"

  def contact_email(contact)
    @contact = contact

    mail(
      to: Rails.application.config.contacts_destination,
      subject: t('mailers.contact.subject', name: @contact.name)
    )
  end
end
