# This migration comes from raddar_zines (originally 20131218000952)
class AddUserToRaddarZinesPosts < ActiveRecord::Migration
  def change
    add_reference :raddar_zines_posts, :user, index: true
  end
end
