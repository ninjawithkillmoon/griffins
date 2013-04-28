class AddCompetitionIdToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :competition_id, :integer
  end
end
