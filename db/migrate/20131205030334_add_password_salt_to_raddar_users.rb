class AddPasswordSaltToRaddarUsers < ActiveRecord::Migration
  def change
    add_column :raddar_users, :password_salt, :string
  end
end
