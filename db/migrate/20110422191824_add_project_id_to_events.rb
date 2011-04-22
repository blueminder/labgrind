class AddProjectIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :project_id, :integer
  end

  def self.down
    remove_column :events, :project_id
  end
end
