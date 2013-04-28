class RemoveMaleFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :male
  end

  def down
    add_column :users, :male, :boolean
  end
end
