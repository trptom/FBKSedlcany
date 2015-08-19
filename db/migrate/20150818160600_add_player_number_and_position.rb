class AddPlayerNumberAndPosition < ActiveRecord::Migration
  def change
    add_column :players, :shirt_number, :integer, :null => true, :default => nil
    add_column :players, :position, :string, :null => true, :default => nil
  end
end
