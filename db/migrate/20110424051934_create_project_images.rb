class CreateProjectImages < ActiveRecord::Migration
  def self.up
    create_table :project_images do |t|
      t.string :caption
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :project_images
  end
end
