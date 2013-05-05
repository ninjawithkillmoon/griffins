class SeasonsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Seasons", :seasons_path

  def index
    @seasons = Season.paginate(page: params[:page])

    @total = @seasons.total_entries
  end

  def show
    fetch_season

    add_breadcrumb @season.name, @season
  end

  def new
    @season = Season.new

    add_breadcrumb "New", new_season_path
  end

  def create
    @season = Season.new(params[:season])

    add_breadcrumb "New", new_season_path

    if @season.save
      flash[:success] = t(:season_created)
      redirect_to @season
    else
      render 'new'
    end
  end

  def edit
    fetch_season

    add_breadcrumb @season.name, @season
    add_breadcrumb "Edit", edit_season_path(@season)
  end

  def update
    fetch_season

    add_breadcrumb @season.name, @season
    add_breadcrumb "Edit", edit_season_path(@season)

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
