class AddDateEndToSeason < ActiveRecord::Migration
  def change
    add_column :seasons, :date_end, :date
  end
end
