class UserMailer < Devise::Mailer
  helper 'application'
  layout 'mailer'
  default from: "#{ Rails.application.config.app_name } "\
    "<#{ Rails.application.config.default_from }>"

  def confirmation_instructions(record, token, opts = {})
    @token = token

    opts[:template_path] = 'users/mailer'

    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts = {})
    @token = token

    opts[:template_path] = 'users/mailer'

    devise_mail(record, :reset_password_instructions, opts)
  end
end
