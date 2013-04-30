class SeasonsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @seasons = Season.paginate(page: params[:page])
  end

  def show
    fetch_season
  end

  def new
    @season = Season.new
  end

  def create
    @season = Season.new(params[:season])

    if @season.save
      flash[:success] = t(:season_created)
      redirect_to @season
    else
      render 'new'
    end
  end

  def edit
    fetch_season
    @competitions = Competition.all
  end

  def update
    fetch_season

    if @season.update_attributes(params[:season])
      flash[:success] = t(:season_updated)
      redirect_to @season
    else
      render 'edit'
    end
  end

  def destroy
    fetch_season.destroy

    flash[:success] = t(:season_deleted)
    redirect_to seasons_url
  end

  private # ----------------------------------------------------------

  def fetch_season
    @season = Season.find(params[:id])
  end
end
