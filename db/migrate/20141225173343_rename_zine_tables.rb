class RenameZineTables < ActiveRecord::Migration
  def change
    rename_table 'raddar_zines_zines', 'zines'
    rename_table 'raddar_zines_posts', 'posts'
    rename_table 'raddar_zines_comments', 'comments'

    reversible do |dir|
      dir.up do
        # Change activities
        Raddar::Activity.where(key: 'zines.comments.create')
          .update_all(key: 'comments.create')
        Raddar::Activity.where(key: 'zines.posts.create')
          .update_all(key: 'posts.create')
        Raddar::Activity.where(key: 'zines.zines.create')
          .update_all(key: 'zines.create')

        Raddar::Activity.where(subject_type: 'Raddar::Zines::Zine')
          .update_all(subject_type: 'Zine')
        Raddar::Activity.where(subject_type: 'Raddar::Zines::Post')
          .update_all(subject_type: 'Post')
        Raddar::Activity.where(subject_type: 'Raddar::Zines::Comment')
          .update_all(subject_type: 'Comment')

        # Change followerships
        Raddar::Followership.where(followable_type: 'Raddar::Zines::Zine')
          .update_all(followable_type: 'Zine')

        # Change notifications
        Raddar::Notification.where(notifiable_type: 'Raddar::Zines::Comment')
          .update_all(notifiable_type: 'Comment')

        Raddar::Notification.where(event: 'new_zine_post_comment')
          .update_all(notifiable_type: 'new_comment')

        # Change watches
        Raddar::Watch.where(watchable_type: 'Raddar::Zines::Post')
          .update_all(watchable_type: 'Post')

        # Change reviews
        Raddar::Review.where(reviewable_type: 'Raddar::Zines::Post')
          .update_all(reviewable_type: 'Post')
        Raddar::Review.where(reviewable_type: 'Raddar::Zines::Comment')
          .update_all(reviewable_type: 'Comment')
      end

      dir.down do
        # Change activities
        Raddar::Activity.where(key: 'comments.create')
          .update_all(key: 'zines.comments.create')
        Raddar::Activity.where(key: 'posts.create')
          .update_all(key: 'zines.posts.create')
        Raddar::Activity.where(key: 'zines.create')
          .update_all(key: 'zines.zines.create')

        Raddar::Activity.where(subject_type: 'Zine')
          .update_all(subject_type: 'Raddar::Zines::Zine')
        Raddar::Activity.where(subject_type: 'Post')
          .update_all(subject_type: 'Raddar::Zines::Post')
        Raddar::Activity.where(subject_type: 'Comment')
          .update_all(subject_type: 'Raddar::Zines::Comment')

        # Change followerships
        Raddar::Followership.where(followable_type: 'Zine')
          .update_all(followable_type: 'Raddar::Zines::Zine')

        # Change notifications
        Raddar::Notification.where(notifiable_type: 'Comment')
          .update_all(notifiable_type: 'Raddar::Zines::Comment')

        Raddar::Notification.where(event: 'new_comment')
          .update_all(notifiable_type: 'new_zine_post_comment')

        # Change watches
        Raddar::Watch.where(watchable_type: 'Post')
          .update_all(watchable_type: 'Raddar::Zines::Post')

        # Change reviews
        Raddar::Review.where(reviewable_type: 'Post')
          .update_all(reviewable_type: 'Raddar::Zines::Post')
        Raddar::Review.where(reviewable_type: 'Comment')
          .update_all(reviewable_type: 'Raddar::Zines::Comment')
      end
    end
  end
end
