class AddDescriptionToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :description, :string
  end

  def self.down
    remove_column :items, :description
  end
end
