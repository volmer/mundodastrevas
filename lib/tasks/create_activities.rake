namespace :mundodastrevas do
  namespace :activities do
    desc 'Create all missing activities'
    task create: :environment do
      Raddar::User.all.each do |user|
        if user.activities.exists?(key: 'users.sign_up')
          puts "Skipped users.sign_up for #{user}"
        else
          Raddar::Activity.create!(
            user: user,
            subject: user,
            key: 'users.sign_up',
            privacy: 'public',
            created_at: user.created_at
          )
        end
      end

      Raddar::Followership.all.each do |followership|
        if followership.activities.exists?(key: 'followerships.create')
          puts "Skipped followerships.create for #{followership}"
        else
          Raddar::Activity.create!(
            user: followership.user,
            subject: followership,
            key: 'followerships.create',
            privacy: 'public',
            created_at: followership.created_at
          )
        end
      end

      Raddar::ExternalAccount.all.each do |external_account|
        if external_account.activity.present?
          puts "Skipped external_accounts.create for #{external_account}"
        else
          privacy = external_account.user.privacy[external_account.provider] || 'public'
          Raddar::Activity.create!(
            user: external_account.user,
            subject: external_account,
            key: 'external_accounts.create',
            privacy: privacy,
            created_at: external_account.created_at
          )
        end
      end

      Raddar::Review.all.each do |review|
        if review.activity
          puts "Skipped reviews.create for #{review}"
        else
          privacy = (review.value == 'hated') ? 'only_me' : 'public'
          Raddar::Activity.create!(
            user: review.user,
            subject: review,
            key: 'reviews.create',
            privacy: privacy,
            created_at: review.created_at
          )
        end
      end

      Raddar::Zines::Zine.all.each do |zine|
        if zine.activity
          puts "Skipped zines.zines.create for #{zine}"
        else
          Raddar::Activity.create!(
            user: zine.user,
            subject: zine,
            key: 'zines.zines.create',
            privacy: 'public',
            created_at: zine.created_at
          )
        end
      end

      Raddar::Zines::Post.all.each do |post|
        if post.activity
          puts "Skipped zines.posts.create for #{post}"
        else
          Raddar::Activity.create!(
            user: post.user,
            subject: post,
            key: 'zines.posts.create',
            privacy: 'public',
            created_at: post.created_at
          )
        end
      end

      Raddar::Zines::Comment.all.each do |comment|
        if comment.activity
          puts "Skipped zines.comments.create for #{comment}"
        else
          Raddar::Activity.create!(
            user: comment.user,
            subject: comment,
            key: 'zines.comments.create',
            privacy: 'public',
            created_at: comment.created_at
          )
        end
      end

      Raddar::Forums::Post.all.each do |post|
        if post.activity
          puts "Skipped forums.posts.create for #{post}"
        else
          Raddar::Activity.create!(
            user: post.user,
            subject: post,
            key: 'forums.posts.create',
            privacy: 'public',
            created_at: post.created_at
          )
        end
      end
    end
  end
end
