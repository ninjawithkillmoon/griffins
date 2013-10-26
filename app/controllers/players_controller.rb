class PlayersController < ApplicationController
  include PlayersHelper

  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Players", :players_path

  def index
    fetch_player

    if @player
      redirect_to @player
    else
      fetch_players
      fetch_players_all # used for the player selector in the search filters
      fetch_seasons

      @total = @players.total_entries
    end
  end

  def show
    fetch_player

    add_breadcrumb full_name(@player), @player
  end

  def new
    @player = Player.new
    @player_import = PlayerImport.new # required for rendering player_imports form

    add_breadcrumb "New", new_player_path
  end

  def create
    @player = Player.new(params[:player])
    @player_import = PlayerImport.new(params[:player_import]) # required for rendering player_imports form

    add_breadcrumb "New", new_player_path

    if @player.save
      flash[:success] = t(:player_created)
      redirect_to @player
    else
      render 'new'
    end
  end

  def edit
    fetch_player

    add_breadcrumb full_name(@player), @player
    add_breadcrumb "Edit", edit_player_path(@player)
  end

  def update
    fetch_player

    add_breadcrumb full_name(@player), @player
    add_breadcrumb "Edit", edit_player_path(@player)

    if @player.update_attributes(params[:player])
      flash[:success] = t(:player_updated)
      redirect_to @player
    else
      render 'edit'
    end
  end

  def destroy
    fetch_player.destroy

    flash[:success] = t(:player_deleted)
    redirect_to players_path
  end

  private # ----------------------------------------------------------

  def fetch_player
    if !params[:id].blank?
      @player = Player.find(params[:id])
    end
  end

  def fetch_players
    @players = Player.active(params[:active])
                     .with_sex(params[:sex])
                     .played_in_season(params[:season_id])
                     .order("name_family, name_given")
                     .paginate(page: params[:page])
  end

  def fetch_players_all
    @players_all = Player.all
  end

  def fetch_seasons
    @seasons = Season.order("date_start DESC")
  end
end
