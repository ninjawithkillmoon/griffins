class DivisionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Divisions", :divisions_path

  def index
    fetch_divisions
    fetch_seasons
  end

  def show
    fetch_division

    add_breadcrumb @division.name, @division
  end

  def new
    @division = Division.new

    add_breadcrumb "New", new_division_path
  end

  def create
    @division = Division.new(params[:division])

    add_breadcrumb "New", new_division_path

    if @division.save
      flash[:success] = t(:division_created)
      redirect_to @division
    else
      render 'new'
    end
  end

  def edit
    fetch_division

    add_breadcrumb @division.name, @division
    add_breadcrumb "Edit", edit_division_path(@division)
  end

  def update
    fetch_division

    add_breadcrumb @division.name, @division
    add_breadcrumb "Edit", edit_division_path(@division)

    if @division.update_attributes(params[:division])
      flash[:success] = t(:division_updated)
      redirect_to @division
    else
      render 'edit'
    end
  end

  def destroy
    fetch_division.destroy

    flash[:success] = t(:division_deleted)
    redirect_to divisions_url
  end

  private # ----------------------------------------------------------

  def fetch_division
    @division = Division.find(params[:id])
  end

  def fetch_divisions
    @divisions = Division.joins('LEFT JOIN seasons on seasons.id = divisions.season_id').order('seasons.date_start DESC, divisions.sex, divisions.name').paginate(page: params[:page])
  end

  def fetch_seasons
    @seasons = Season.order("date_start DESC")
  end
end
