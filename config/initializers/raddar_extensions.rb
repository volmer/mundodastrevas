require Rails.root + 'lib/devise/encryptable/encryptors/dark_encryptor'
require Rails.root + 'lib/mundodastrevas/user_extension'
require Rails.root + 'lib/mundodastrevas/forum_extension'
require Rails.root + 'lib/mundodastrevas/zine_extension'

Raddar::User.send(:include, Mundodastrevas::UserExtension)
Raddar::Forums::Forum.send(:include, Mundodastrevas::ForumExtension)
Raddar::Zines::Zine.send(:include, Mundodastrevas::ZineExtension)

Raddar::Zines::ZinesController.class_eval do
  helper Bootsy::Engine.helpers

  def zine_params
    params.require(:zine).permit(:name, :slug, :description, :image, :universe_id)
  end
end
