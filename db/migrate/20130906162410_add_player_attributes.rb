class AddPlayerAttributes < ActiveRecord::Migration
  def change
    add_column :players, :weight, :integer, :null => true, :default => nil
    add_column :players, :height, :integer, :null => true, :default => nil
    add_column :players, :stick_holding, :integer, :null => true, :default => nil
  end
end
