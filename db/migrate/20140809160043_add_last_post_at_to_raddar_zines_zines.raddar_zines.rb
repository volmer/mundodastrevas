# This migration comes from raddar_zines (originally 20140809153547)
class AddLastPostAtToRaddarZinesZines < ActiveRecord::Migration
  def change
    add_column :raddar_zines_zines, :last_post_at, :datetime

    Raddar::Zines::Zine.all.each do |zine|
      last_post = zine.posts.order('created_at DESC').first
      zine.update(last_post_at: last_post.created_at) if last_post
    end
  end
end
