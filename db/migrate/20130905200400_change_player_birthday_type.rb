class ChangePlayerBirthdayType < ActiveRecord::Migration
  def change
    change_column :players, :birthday, :date, :null => true, :default => nil
  end
end
