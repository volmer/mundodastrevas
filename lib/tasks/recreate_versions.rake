UPLOADS_PATH = '/Users/volmer/backups/mundodastrevas/uploads'

def versions_for_users(session)
  puts 'Recreating users avatars'

  count = Raddar::User.count

  bar = ProgressBar.new(count)

  Raddar::User.all.each do |user|
    if user.avatar?
      mongodb_user = session[:users].find(name: user.name).first

      File.open(UPLOADS_PATH + "/user/#{ mongodb_user['_id'] }/image/#{ mongodb_user['image'] }") do |file|
        user.avatar = file

        user.save!
      end
    end

    bar.increment!
  end
end

def versions_for_zines
  puts 'Recreating zines images'

  count = Raddar::Zines::Zine.count

  bar = ProgressBar.new(count)

  Raddar::Zines::Zine.all.each do |zine|
    if zine.image?
      File.open(zine.image.file.file) do |file|
        zine.image = file

        zine.save!
      end
    end

    bar.increment!
  end
end

def versions_for_posts
  puts 'Recreating posts images'

  count = Raddar::Zines::Post.count

  bar = ProgressBar.new(count)

  Raddar::Zines::Post.all.each do |post|
    if post.image?
      File.open(post.image.file.file) do |file|
        post.image = file

        post.save!
      end
    end

    bar.increment!
  end
end

def versions_for_universes
  puts 'Recreating universes images'

  count = Universe.count

  bar = ProgressBar.new(count)

  Universe.all.each do |universe|
    if universe.image?
      File.open(universe.image.file.file) do |file|
        universe.image = file

        universe.save!
      end
    end

    bar.increment!
  end
end

namespace :mundodastrevas do
  desc 'Recreates the uploaded images for users, zines, posts and universes'
  task :recreate_versions, [:host, :port, :dbname] => :environment do |t, args|
    session = Moped::Session.new(["#{ args[:host] }:#{ args[:port] }"])
    session.use args[:dbname]

    ActiveRecord::Base.record_timestamps = false

    versions_for_users(session)
    versions_for_zines
    versions_for_posts
    versions_for_universes
  end
end
