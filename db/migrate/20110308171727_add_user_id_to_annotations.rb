class AddUserIdToAnnotations < ActiveRecord::Migration
  def self.up
    add_column :annotations, :user_id, :integer
  end

  def self.down
    remove_column :annotations, :user_id
  end
end
