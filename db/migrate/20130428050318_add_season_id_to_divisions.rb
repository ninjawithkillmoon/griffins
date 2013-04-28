class AddSeasonIdToDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :season_id, :integer
  end
end
