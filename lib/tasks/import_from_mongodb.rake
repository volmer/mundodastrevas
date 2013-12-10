require 'pp'

UPLOADS_PATH = '/Users/volmer/backups/mundodastrevas/uploads'

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

def import_forums(session)
  puts 'Importing forums'

  count = session[:forums].find.count

  bar = ProgressBar.new(count)

  session[:forums].find.each do |forum|
    raddar_forum = Raddar::Forums::Forum.new(
      slug:                   forum['_slugs'].first,
      description:            forum['description'],
      name:                   forum['name'],
      created_at:             forum['created_at'],
      updated_at:             forum['updated_at']
    )

    if forum['universe_id'].present?
      universe = session[:universes].find(_id: forum['universe_id']).first
      imported_universe = Universe.find_by(name: universe['name'])

      raddar_forum.universe = imported_universe

      puts "Universe not found for #{ raddar_forum}!" if raddar_forum.universe.blank?
    end

    raddar_forum.save!

    bar.increment!
  end

  puts "Imported #{ Raddar::Forums::Forum.count } forums."
end

def import_topics(session)
  puts 'Importing topics'

  count = session[:topics].find.count

  bar = ProgressBar.new(count)

  session[:topics].find.each do |topic|
    forum = session[:forums].find(_id: topic['forum_id']).first
    raddar_forum = Raddar::Forums::Forum.find_by(name: forum['name'])

    user = session[:users].find(_id: topic['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    raddar_topic = Raddar::Forums::Topic.new(
      forum:                  raddar_forum,
      user:                   raddar_user,
      views:                  topic['views'],
      name:                   topic['name'],
      created_at:             topic['created_at'],
      updated_at:             topic['updated_at']
    )

    raddar_topic.save!

    bar.increment!
  end

  puts "Imported #{ Raddar::Forums::Topic.count } topics."
end

def import_forum_posts(session)
  puts 'Importing forum posts'

  count = session[:posts].find.count

  bar = ProgressBar.new(count)

  session[:posts].find.each do |forum_post|
    topic = session[:topics].find(_id: forum_post['topic_id']).first
    raddar_topic = Raddar::Forums::Topic.find_by(name: topic['name'], created_at: topic['created_at'], views: topic['views'])

    user = session[:users].find(_id: forum_post['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    raddar_forum_post = Raddar::Forums::Post.new(
      topic:                  raddar_topic,
      user:                   raddar_user,
      content:                forum_post['content'],
      created_at:             forum_post['created_at'],
      updated_at:             forum_post['updated_at']
    )

    raddar_forum_post.save!

    bar.increment!
  end

  puts "Imported #{ Raddar::Forums::Post.count } forum posts."
end

def import_zines(session, upload_images = true)
  puts 'Importing zines'

  count = session[:pubs].find.count

  bar = ProgressBar.new(count)

  session[:pubs].find.each do |zine|
    user = session[:users].find(_id: zine['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    raddar_zine = Raddar::Zines::Zine.new(
      user:                   raddar_user,
      slug:                   zine['_slugs'].first,
      description:            zine['description'],
      name:                   zine['name'],
      starred:                zine['main'],
      created_at:             zine['created_at'],
      updated_at:             zine['updated_at']
    )

    if zine['universe_id'].present?
      universe = session[:universes].find(_id: zine['universe_id']).first
      imported_universe = Universe.find_by(name: universe['name'])

      raddar_zine.universe = imported_universe

      puts "Universe not found for #{ raddar_zine }!" if raddar_zine.universe.blank?
    end

    if zine['image'].present? && upload_images
      begin
        file = File.open(UPLOADS_PATH + "/pub/#{ zine['_id'] }/image/#{ zine['image'] }")

        raddar_zine.image = file

        raddar_zine.save!

        file.close
      rescue StandardError => e
        puts "Error while processing #{ raddar_zine }'s image"
        puts e.message

        raddar_zine.save!
      end
    else
      raddar_zine.save!
    end

    bar.increment!
  end

  puts "Imported #{ Raddar::Zines::Zine.count } zines."
end

def import_zine_posts(session, upload_images = true)
  puts 'Importing zine posts'

  count = session[:stuffs].find.count

  bar = ProgressBar.new(count)

  session[:stuffs].find.each do |zine_post|
    zine = session[:pubs].find(_id: zine_post['pub_id']).first
    raddar_zine = Raddar::Zines::Zine.find_by(slug: zine['_slugs'].first)

    raddar_zine_post = Raddar::Zines::Post.new(
      zine:                   raddar_zine,
      slug:                   zine_post['_slugs'].first,
      content:                zine_post['content'],
      views:                  zine_post['views'],
      name:                   zine_post['name'],
      created_at:             zine_post['created_at'],
      updated_at:             zine_post['updated_at']
    )

    unless raddar_zine_post.valid?
      puts "Post #{ raddar_zine_post } is not valid."
      puts "Removing slug '#{ raddar_zine_post.slug }'..."

      raddar_zine_post.slug = nil
    end

    if zine_post['image'].present? && upload_images
      begin
        file = File.open(UPLOADS_PATH + "/stuff/#{ zine_post['_id'] }/image/#{ zine_post['image'] }")

        raddar_zine_post.image = file

        raddar_zine_post.save!

        file.close
      rescue StandardError => e
        puts "Error while processing #{ raddar_zine_post }'s image"
        puts e.message

        raddar_zine_post.save!
      end
    else
      raddar_zine_post.save!
    end

    bar.increment!
  end

  puts "Imported #{ Raddar::Zines::Post.count } zine posts."
end

def import_comments(session)
  puts 'Importing comments'

  count = session[:comments].find(commentable_type: 'Stuff').count

  bar = ProgressBar.new(count)

  session[:comments].find(commentable_type: 'Stuff').each do |comment|
    post = session[:stuffs].find(_id: comment['commentable_id']).first
    raddar_post = Raddar::Zines::Post.find_by(name: post['name'], created_at: post['created_at'], views: post['views'])

    user = session[:users].find(_id: comment['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    raddar_comment = Raddar::Zines::Comment.new(
      post:                   raddar_post,
      user:                   raddar_user,
      content:                comment['content'],
      created_at:             comment['created_at'],
      updated_at:             comment['updated_at']
    )

    raddar_comment.save!

    bar.increment!
  end

  puts "Imported #{ Raddar::Zines::Comment.count } comments."
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
        file = File.open(UPLOADS_PATH +  "/universe/#{ universe['_id'] }/image/#{ universe['image'] }")

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

def import_messages(session)
  puts 'Importing messages'

  count = session[:messages].find.count

  bar = ProgressBar.new(count)

  session[:messages].find.each do |message|
    user = session[:users].find(_id: message['sender_id']).first
    sender = Raddar::User.find_by(name: user['name'])
    user = session[:users].find(_id: message['recipient_id']).first
    recipient = Raddar::User.find_by(name: user['name'])

    raddar_message = Raddar::Message.new(
      sender:     sender,
      recipient:  recipient,
      read:       message['recipient_status'] != 'unread',
      content:    message['content'],
      created_at: message['created_at'],
      updated_at: message['updated_at']
    )

    raddar_message.save!

    bar.increment!
  end

  puts "Imported #{ Raddar::Message.count } messages."
end

def import_followerships(session)
  puts 'Importing followerships'

  count = session[:followerships].find.count

  bar = ProgressBar.new(count)

  session[:followerships].find.each do |followership|
    user = session[:users].find(_id: followership['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    case followership['followable_type']
    when 'User'
      user = session[:users].find(_id: followership['followable_id']).first
      followable = Raddar::User.find_by(name: user['name'])
    when 'Pub'
      zine = session[:pubs].find(_id: followership['followable_id']).first
      followable = Raddar::Zines::Zine.find_by(slug: zine['_slugs'].first)
    when 'Forum'
      forum = session[:forums].find(_id: followership['followable_id']).first
      followable = Raddar::Forums::Forum.find_by(name: forum['name'])
    end

    raddar_followership = Raddar::Followership.new(
      user:       raddar_user,
      followable: followable,
      created_at: followership['created_at'],
      updated_at: followership['updated_at']
    )

    unless raddar_followership.save
      puts "Failed for #{ raddar_followership }."
      pp raddar_followership.errors
    end

    bar.increment!
  end

  puts "Imported #{ Raddar::Followership.count } followerships."
end

def import_reviews(session)
  puts 'Importing reviews'

  count = session[:votes].find.count

  bar = ProgressBar.new(count)

  session[:votes].find.each do |review|
    user = session[:users].find(_id: review['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    case review['votable_type']
    when 'Comment'
      comment = session[:comments].find(_id: review['votable_id']).first
      reviewable = Raddar::Zines::Comment.find_by(content: comment['content'], created_at: comment['created_at'])
    when 'Stuff'
      zine_post = session[:stuffs].find(_id: review['votable_id']).first
      reviewable = Raddar::Zines::Post.find_by(name: zine_post['name'], created_at: zine_post['created_at'])
    when 'Post'
      forum_post = session[:posts].find(_id: review['votable_id']).first
      reviewable = Raddar::Forums::Post.find_by(content: forum_post['content'], created_at: forum_post['created_at'])
    end

    case review['value'].to_s
    when 'like'
      value = 'loved'
    when 'dislike'
      value = 'hated'
    end

    raddar_review = Raddar::Ratings::Review.new(
      user:       raddar_user,
      reviewable: reviewable,
      value:      value,
      created_at: review['created_at'],
      updated_at: review['updated_at']
    )

    raddar_review.save!

    bar.increment!
  end

  puts "Imported #{ Raddar::Ratings::Review.count } reviews."
end

def import_watches(session)
  puts 'Importing watches'

  count = session[:watchings].find.count

  bar = ProgressBar.new(count)

  session[:watchings].find.each do |watch|
    user = session[:users].find(_id: watch['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    case watch['watchable_type']
    when 'Topic'
      topic = session[:topics].find(_id: watch['watchable_id']).first
      watchable = Raddar::Forums::Topic.find_by(name: topic['name'], views: topic['views'])
    when 'Stuff'
      post = session[:stuffs].find(_id: watch['watchable_id']).first
      watchable = Raddar::Zines::Post.find_by(name: post['name'], created_at: post['created_at'])
    end

    if watch['watchable_type'] != 'Venue'
      raddar_watch = Raddar::Watchers::Watch.new(
        user:       raddar_user,
        watchable:  watchable,
        created_at: watch['created_at'],
        updated_at: watch['updated_at']
      )

      unless raddar_watch.save
        puts "Failed for #{ raddar_watch }."
        pp raddar_watch.errors
      end
    end

    bar.increment!
  end

  puts "Imported #{ Raddar::Watchers::Watch.count } watches."
end

def import_notifications(session)
  puts 'Importing notifications'

  count = session[:notifications].find.count

  bar = ProgressBar.new(count)

  session[:notifications].find.each do |notification|
    user = session[:users].find(_id: notification['user_id']).first
    raddar_user = Raddar::User.find_by(name: user['name'])

    if notification['content'].include?('começou a seguir você')
      event = 'new_follower'
      user = session[:users].find(_id: notification['notifiable_id']).first
      follower = Raddar::User.find_by(name: user['name'])

      followership = Raddar::Followership.find_by(user: follower, followable: raddar_user)

      if followership
        raddar_notification = Raddar::Notification.new(
          user:           raddar_user,
          notifiable:     followership,
          unread:         notification['status'] == 'unread',
          event:          event,
          created_at:     notification['created_at'],
          updated_at:     notification['updated_at']
        )

        raddar_notification.save!
      end
    end

    bar.increment!
  end

  puts "Imported #{ Raddar::Notification.count } notifications."
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
        file = File.open(UPLOADS_PATH + "/user/#{ user['_id'] }/image/#{ user['image'] }")

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

    import_roles(session)
    import_users(session, false)
    # import_pages(session)
    import_universes(session, false)
    import_forums(session)
    import_topics(session)
    import_forum_posts(session)
    import_zines(session, false)
    import_zine_posts(session, false)
    import_comments(session)
    # import_messages(session)
    # import_followerships(session)
    # import_notifications(session)
    # import_watches(session)
    import_reviews(session)
  end
end
