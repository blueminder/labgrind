class RemoveDatetimeFromAnnotations < ActiveRecord::Migration
  def self.up
    remove_column :annotations, :datetime
  end

  def self.down
    add_column :annotations, :datetime, :datetime
  end
end
