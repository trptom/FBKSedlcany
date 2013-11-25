class CreateWikis < ActiveRecord::Migration
  def self.up
    create_table :wikis do |t|
      t.string :section,        :null => false
      t.string :name,           :null => false
      t.boolean :show_in_menu,  :null => false, :default => false
      t.text :content,          :null => false

      t.timestamps
    end
    
    Wiki.create({
        :section => "sedlcany_open",
        :name => "index_2008",
        :show_in_menu => true,
        :content => ""
    })
    Wiki.create({
        :section => "sedlcany_open",
        :name => "index_2009",
        :show_in_menu => true,
        :content => ""
    })
    Wiki.create({
        :section => "sedlcany_open",
        :name => "index_2010",
        :show_in_menu => true,
        :content => ""
    })
    Wiki.create({
        :section => "sedlcany_open",
        :name => "index_2011",
        :show_in_menu => true,
        :content => ""
    })
    Wiki.create({
        :section => "sedlcany_open",
        :name => "index_2012",
        :show_in_menu => true,
        :content => ""
    })
    Wiki.create({
        :section => "sedlcany_open",
        :name => "index_2013",
        :show_in_menu => true,
        :content => ""
    })
  end
  
  def self.down
    drop_table :wikis
  end
end
