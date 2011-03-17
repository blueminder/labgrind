class AddFieldsToTransaction < ActiveRecord::Migration
  def self.up
    add_column :transactions, :status, :string
    add_column :transactions, :due_date, :string
  end

  def self.down
    remove_column :transactions, :due_date
    remove_column :transactions, :status
  end
end
