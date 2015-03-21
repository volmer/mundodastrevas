class RenameTables < ActiveRecord::Migration
  def change
    rename_table 'raddar_activities', 'activities'
    rename_table 'raddar_external_accounts', 'external_accounts'
    rename_table 'raddar_followerships', 'followerships'
    rename_table 'raddar_messages', 'messages'
    rename_table 'raddar_notifications', 'notifications'
    rename_table 'raddar_pages', 'pages'
    rename_table 'raddar_reviews', 'reviews'
    rename_table 'raddar_roles', 'roles'
    rename_table 'raddar_roles_users', 'roles_users'
    rename_table 'raddar_taggings', 'taggings'
    rename_table 'raddar_tags', 'tags'
    rename_table 'raddar_users', 'users'
    rename_table 'raddar_watches', 'watches'

    reversible do |dir|
      dir.up do
        # Change activities
        Activity.where(subject_type: 'Raddar::Followership')
          .update_all(subject_type: 'Followership')
        Activity.where(subject_type: 'Raddar::Review')
          .update_all(subject_type: 'Review')
        Activity.where(subject_type: 'Raddar::User')
          .update_all(subject_type: 'User')
        Activity.where(subject_type: 'Raddar::ExternalAccount')
          .update_all(subject_type: 'ExternalAccount')

        # Change followerships
        Followership.where(followable_type: 'Raddar::User')
          .update_all(followable_type: 'User')

        # Change notifications
        Notification.where(notifiable_type: 'Raddar::Followership')
          .update_all(notifiable_type: 'Followership')
        Notification.where(notifiable_type: 'Raddar::Message')
          .update_all(notifiable_type: 'Message')

        PgSearch::Document.delete_all(searchable_type: 'Raddar::Page')
        PgSearch::Multisearch.rebuild(Page)

        PgSearch::Document.delete_all(searchable_type: 'Raddar::User')
        PgSearch::Multisearch.rebuild(User)
      end

      dir.down do
        # Change activities
        Activity.where(subject_type: 'Followership')
          .update_all(subject_type: 'Raddar::Followership')
        Activity.where(subject_type: 'Review')
          .update_all(subject_type: 'Raddar::Review')
        Activity.where(subject_type: 'User')
          .update_all(subject_type: 'Raddar::User')
        Activity.where(subject_type: 'ExternalAccount')
          .update_all(subject_type: 'Raddar::ExternalAccount')

        # Change followerships
        Followership.where(followable_type: 'User')
          .update_all(followable_type: 'Raddar::User')

        # Change notifications
        Notification.where(notifiable_type: 'Followership')
          .update_all(notifiable_type: 'Raddar::Followership')
        Notification.where(notifiable_type: 'Message')
          .update_all(notifiable_type: 'Raddar::Message')

        PgSearch::Document.delete_all(searchable_type: 'Page')
        PgSearch::Document.delete_all(searchable_type: 'User')
      end
    end
  end
end
