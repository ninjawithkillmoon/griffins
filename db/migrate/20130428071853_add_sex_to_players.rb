class AddSexToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :sex, :integer
  end
end
