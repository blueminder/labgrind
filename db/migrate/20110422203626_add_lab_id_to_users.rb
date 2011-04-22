class AddLabIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :lab_id, :integer
  end

  def self.down
    remove_column :users, :lab_id
  end
end
