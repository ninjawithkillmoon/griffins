# Ripped shamelessly from https://github.com/railscasts/396-importing-csv-and-excel
class PlayerImportsController < ApplicationController
  def new
    @player = Player.new # required when rendering players/new below
    @player_import = PlayerImport.new(params[:player_import])

    render 'players/new'
  end

  def create
    @player = Player.new # required when rendering players/new below
    @player_import = PlayerImport.new(params[:player_import])

    if @player_import.save
      flash[:success] = t(:player_imported)
      redirect_to players_path
    else
      render 'players/new'
    end
  end

end