# This migration comes from raddar (originally 20131026133924)
class CreateRaddarExternalAccounts < ActiveRecord::Migration
  def change
    create_table :raddar_external_accounts do |t|
      t.string :provider
      t.string :token
      t.string :secret
      t.string :name
      t.string :url
      t.string :email
      t.string :uid
      t.boolean :verified
      t.references :user, index: true

      t.timestamps
    end

    add_index :raddar_external_accounts, [:token, :provider], unique: true
    add_index :raddar_external_accounts, [:name, :provider], unique: true
    add_index :raddar_external_accounts, [:url, :provider], unique: true
    add_index :raddar_external_accounts, [:user_id, :provider], unique: true
    add_index :raddar_external_accounts, [:uid, :provider], unique: true
  end
end
