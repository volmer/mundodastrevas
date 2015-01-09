class FixCommentsNotifications < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Raddar::Notification.where(notifiable_type: 'new_comment')
          .update_all(notifiable_type: 'Comment')

        Raddar::Notification.where(event: 'new_zine_post_comment')
          .update_all(event: 'new_comment')
      end

      dir.down do
        Raddar::Notification.where(notifiable_type: 'Comment')
          .update_all(notifiable_type: 'new_comment')

        Raddar::Notification.where(event: 'new_comment')
          .update_all(event: 'new_zine_post_comment')
      end
    end
  end
end
