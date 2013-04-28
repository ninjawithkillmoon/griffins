class RemoveMaleFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :male
  end

  def down
    add_column :players, :male, :boolean
  end
end
