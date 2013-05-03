class TeamsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Teams", :teams_path

  def index
    @teams = Team.paginate(page: params[:page])
  end

  def show
    fetch_team

    add_breadcrumb @team.name, @team
  end

  def new
    @team = Team.new

    add_breadcrumb "New", new_team_path
  end

  def create
    @team = Team.new(params[:team])

    add_breadcrumb "New", new_team_path

    if @team.save
      flash[:success] = t(:team_created)
      redirect_to @team
    else
      render 'new'
    end
  end

  def edit
    fetch_team

    add_breadcrumb @team.name, @team
    add_breadcrumb "Edit", edit_team_path(@team)
  end

  def update
    fetch_team

    add_breadcrumb @team.name, @team
    add_breadcrumb "Edit", edit_team_path(@team)

    if @team.update_attributes(params[:team])
      flash[:success] = t(:team_updated)
      redirect_to @team
    else
      render 'edit'
    end
  end

  def destroy
    fetch_team.destroy

    flash[:success] = t(:team_deleted)
    redirect_to teams_url
  end

  private # ----------------------------------------------------------

  def fetch_team
    @team = Team.find(params[:id])
  end
end
