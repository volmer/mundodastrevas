require 'pp'

module UserWithoutPassword
  extend ActiveSupport::Concern

  included do
    def password_required?
      false
    end
  end
end

def import_roles(session)
  puts 'Importing roles'

  count = session[:roles].find.count

  bar = ProgressBar.new(count)

  session[:roles].find.each do |role|
    raddar_role = Raddar::Role.new(
      name:                   role['name'],
      created_at:             role['created_at'],
      updated_at:             role['updated_at']
    )

    raddar_role.save!

    bar.increment!
  end
end

def import_pages(session)
  puts 'Importing pages'

  count = session[:pages].find.count

  bar = ProgressBar.new(count)

  session[:pages].find.each do |page|
    raddar_page = Raddar::Page.new(
      slug:                   page['name'],
      content:                page['content'],
      title:                  page['title'],
      created_at:             page['created_at'],
      updated_at:             page['updated_at']
    )

    raddar_page.save!

    bar.increment!
  end
end

def import_universes(session, upload_images = true)
  puts 'Importing universes'

  count = session[:universes].find.count

  bar = ProgressBar.new(count)

  session[:universes].find.each do |universe|
    imported_universe = Universe.new(
      slug:                  universe['_slugs'].first,
      description:           universe['description'],
      name:                  universe['name'],
      created_at:            universe['created_at'],
      updated_at:            universe['updated_at']
    )

    if universe['image'].present? && upload_images
      begin
        file = File.open("/Users/volmer/backups/mundodastrevas/uploads/universe/#{ universe['_id'] }/image/#{ universe['image'] }")

        imported_universe.image = file

        imported_universe.save!

        file.close
      rescue StandardError => e
        puts "Error while processing #{ imported_universe }'s image"
        puts e.message

        imported_universe.save!
      end
    else
      imported_universe.save!
    end

    bar.increment!
  end

  puts "Imported #{ Universe.count } universes."
end

def import_external_accounts(session)
  # We'll cannot import them cause they don't include :uid
  puts 'Importing external accounts'

  count = session[:accounts].find.count

  bar = ProgressBar.new(count)

  session[:accounts].find.each do |account|
    user = session[:users].find(_id: account['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    raddar_account = Raddar::ExternalAccount.new(
      user:       raddar_user,
      provider:   account['provider'],
      token:      account['token'],
      secret:     account['secret'],
      name:       account['name'],
      url:        account['url'],
      email:      account['email'],
      verified:   account['verified'],
      created_at: account['created_at'],
      updated_at: account['updated_at']
    )

    raddar_account.save!

    raddar_user.privacy[raddar_account.provider] = account['url_privacy']

    raddar_user.save!

    bar.increment!
  end
end

def import_users(session, upload_avatars = true)
  Raddar::User.send(:include, UserWithoutPassword)
  unconfirmed_users = 0

  puts 'Importing users'

  count = session[:users].find.count

  bar = ProgressBar.new(count)

  session[:users].find.each do |user|
    raddar_user = Raddar::User.new(
      email:                  user['email'],
      encrypted_password:     user['encrypted_password'],
      reset_password_token:   user['reset_password_token'],
      reset_password_sent_at: user['reset_password_sent_at'],
      remember_created_at:    user['remember_created_at'],
      sign_in_count:          user['sign_in_count'],
      current_sign_in_at:     user['current_sign_in_at'],
      last_sign_in_at:        user['last_sign_in_at'],
      current_sign_in_ip:     user['current_sign_in_ip'],
      last_sign_in_ip:        user['last_sign_in_ip'],
      confirmation_token:     user['confirmation_token'],
      confirmed_at:           user['confirmed_at'],
      confirmation_sent_at:   user['confirmation_sent_at'],
      unconfirmed_email:      user['unconfirmed_email'],
      name:                   user['name'],
      location:               user['location'],
      birthday:               user['date_of_birth'],
      gender:                 user['gender'].to_s,
      bio:                    user['bio'],
      state:                  user['status'].to_s,
      privacy: {
        birthday:             user['date_of_birth_privacy'].to_s,
        location:             user['location_privacy'].to_s,
        email:                user['email_privacy'].to_s,
        gender:               user['gender_privacy'].to_s
      }, email_preferences: {
        new_message:          user['notify_messages'],
        new_follower:         user['notify_followers']
      },
      created_at:             user['created_at'],
      updated_at:             user['updated_at'],
      password_salt:          user['password_salt']
    )

    if raddar_user.confirmed_at.blank?
      unconfirmed_users += 1
    end

    if user['image'].present? && upload_avatars
      begin
        file = File.open("/Users/volmer/backups/mundodastrevas/uploads/user/#{ user['_id'] }/image/#{ user['image'] }")

        raddar_user.avatar = file

        raddar_user.save!

        file.close
      rescue StandardError => e
        puts "Error while processing #{ raddar_user }'s avatar"
        puts e.message

        raddar_user.save!
      end
    else
      raddar_user.save!
    end

    if user['role_ids'].present?
      puts "User #{ raddar_user } has roles! Associating them now..."

      user['role_ids'].each do |role_id|
        role = session[:roles].find(_id: role_id).first
        raddar_role = Raddar::Role.find_by(name: role['name'])

        puts "Associating with #{ raddar_role.name } role"

        raddar_user.roles << raddar_role
      end

      raddar_user.save!
    end

    bar.increment!
  end

  puts "Imported #{ Raddar::User.count } users."

  puts "Imported #{ unconfirmed_users } unconfirmed users."
end

namespace :mundodastrevas do
  desc 'Import all data from the given MongoDB database'
  task :import_from_mongodb, [:host, :port, :dbname] => :environment do |t, args|
    session = Moped::Session.new(["#{ args[:host] }:#{ args[:port] }"])
    session.use args[:dbname]

    # import_roles(session)
    # import_users(session, false)
    # import_pages(session)
    import_universes(session)
  end
end
