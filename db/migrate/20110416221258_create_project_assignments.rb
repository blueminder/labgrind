class CreateProjectAssignments < ActiveRecord::Migration
  def self.up
    create_table :project_assignments do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :owner

      t.timestamps
    end
  end

  def self.down
    drop_table :project_assignments
  end
end
