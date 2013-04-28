class PlayersController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @players = Player.paginate(page: params[:page])
  end

  def show
    fetch_player
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])

    if @player.save
      flash[:success] = t(:player_created)
      redirect_to @player
    else
      render 'new'
    end
  end

  def edit
    fetch_player
  end

  def update
    fetch_player

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
    redirect_to players_url
  end

  private # ----------------------------------------------------------

  def fetch_player
    @player = Player.find(params[:id])
  end
end
