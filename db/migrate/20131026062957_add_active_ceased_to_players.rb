class AddActiveCeasedToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :active_ceased, :boolean, default: false
  end
end
