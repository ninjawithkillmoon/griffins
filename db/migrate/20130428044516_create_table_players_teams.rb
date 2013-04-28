class CreateTablePlayersTeams < ActiveRecord::Migration
  def up
    create_table(:players_teams, id: false) do |table|
      table.integer :player_id
      table.integer :team_id
    end
  end

  def down
    drop_table :players_teams
  end
end
