# This migration comes from raddar (originally 20131020175354)
class CreateJoinTableRaddarRoleUser < ActiveRecord::Migration
  def change
    create_join_table :roles, :users, table_name: 'raddar_roles_users' do |t|
      t.index [:user_id, :role_id]
      t.index [:role_id, :user_id]
    end
  end
end
