class AddUserAndProjectIdToProjectUpdate < ActiveRecord::Migration
  def self.up
    add_column :project_updates, :user_id, :integer
    add_column :project_updates, :project_id, :integer
  end

  def self.down
    remove_column :project_updates, :project_id
    remove_column :project_updates, :user_id
  end
end
