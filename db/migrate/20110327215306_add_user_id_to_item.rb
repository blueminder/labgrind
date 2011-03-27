class AddUserIdToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :user_id, :integer
  end

  def self.down
    remove_column :items, :user_id
  end
end
