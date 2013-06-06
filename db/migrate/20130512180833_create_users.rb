class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.text :role, :null => false, :default => Hash.new
      t.string :first_name, :null => true, :default => nil
      t.string :second_name, :null => true, :default => nil
      t.string :activation_state
      t.string :activation_token
      t.datetime :activation_expires_at
      t.string :reset_password_token, :null => true, :default => nil
      t.datetime :reset_password_token_expires_at, :null => true, :default => nil
      t.datetime :reset_password_email_sent_at, :null => true, :default => nil

      t.timestamps
    end
  end
end
