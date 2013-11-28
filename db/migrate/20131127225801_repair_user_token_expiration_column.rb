class RepairUserTokenExpirationColumn < ActiveRecord::Migration
  def self.up
    rename_column :users, :activation_expires_at, :activation_token_expires_at
  end

  def self.down
    rename_column :users, :activation_token_expires_at, :activation_expires_at
  end
end
