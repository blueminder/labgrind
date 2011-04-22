class AddLabIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :lab_id, :integer
  end

  def self.down
    remove_column :events, :lab_id
  end
end
