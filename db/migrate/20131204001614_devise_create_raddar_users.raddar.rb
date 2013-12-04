# This migration comes from raddar (originally 20130824222728)
class DeviseCreateRaddarUsers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        enable_extension 'hstore'
      end

      dir.down do
        disable_extension 'hstore'
      end
    end

    create_table(:raddar_users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

      t.string :name
      t.string :location
      t.date :birthday
      t.string :gender
      t.text :bio
      t.string :state, default: 'active'
      t.string :avatar
      t.hstore :privacy
      t.hstore :email_preferences

      t.timestamps
    end

    add_index :raddar_users, :email,                unique: true
    add_index :raddar_users, :reset_password_token, unique: true
    add_index :raddar_users, :name,                 unique: true
    add_index :raddar_users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end
end
