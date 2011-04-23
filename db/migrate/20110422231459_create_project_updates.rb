class CreateProjectUpdates < ActiveRecord::Migration
  def self.up
    create_table :project_updates do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :project_updates
  end
end
