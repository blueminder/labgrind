class SkillsUsers < ActiveRecord::Migration
  def self.up
    create_table :skills_users, :id => false do |t|
      t.references :user
      t.references :skill
      t.timestamps
    end	
  end

  def self.down
    drop_table :skills_users
  end
end
