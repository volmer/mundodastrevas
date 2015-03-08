class RenameForumsTables < ActiveRecord::Migration
  def change
    rename_table 'raddar_forums_forums', 'forums'
    rename_table 'raddar_forums_topics', 'topics'
    rename_table 'raddar_forums_posts', 'forum_posts'

    reversible do |dir|
      dir.up do
        # Change activities
        Raddar::Activity.where(key: 'forums.posts.create')
          .update_all(key: 'forum_posts.create')

        Raddar::Activity.where(subject_type: 'Raddar::Forums::Forum')
          .update_all(subject_type: 'Forum')
        Raddar::Activity.where(subject_type: 'Raddar::Forums::Topic')
          .update_all(subject_type: 'Topic')
        Raddar::Activity.where(subject_type: 'Raddar::Forums::Post')
          .update_all(subject_type: 'ForumPost')

        # Change followerships
        Raddar::Followership.where(followable_type: 'Raddar::Forums::Forum')
          .update_all(followable_type: 'Forum')

        # Change notifications
        Raddar::Notification.where(notifiable_type: 'Raddar::Forums::Post')
          .update_all(notifiable_type: 'ForumPost')

        # Change watches
        Raddar::Watch.where(watchable_type: 'Raddar::Forums::Topic')
          .update_all(watchable_type: 'Topic')

        # Change reviews
        Raddar::Review.where(reviewable_type: 'Raddar::Forums::Post')
          .update_all(reviewable_type: 'ForumPost')
      end

      dir.down do
        # Change activities
        Raddar::Activity.where(key: 'forum_posts.create')
          .update_all(key: 'forums.posts.create')

        Raddar::Activity.where(subject_type: 'Forum')
          .update_all(subject_type: 'Raddar::Forums::Forum')
        Raddar::Activity.where(subject_type: 'Topic')
          .update_all(subject_type: 'Raddar::Forums::Topic')
        Raddar::Activity.where(subject_type: 'ForumPost')
          .update_all(subject_type: 'Raddar::Forums::Post')

        # Change followerships
        Raddar::Followership.where(followable_type: 'Forum')
          .update_all(followable_type: 'Raddar::Forums::Forum')

        # Change notifications
        Raddar::Notification.where(notifiable_type: 'ForumPost')
          .update_all(notifiable_type: 'Raddar::Forums::Post')

        # Change watches
        Raddar::Watch.where(watchable_type: 'Topic')
          .update_all(watchable_type: 'Raddar::Forums::Topic')

        # Change reviews
        Raddar::Review.where(reviewable_type: 'ForumPost')
          .update_all(reviewable_type: 'Raddar::Forums::Post')
      end
    end
  end
end
