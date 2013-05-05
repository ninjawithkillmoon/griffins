class TeamsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Teams", :teams_path

  def index
    @teams = Team.joins('LEFT JOIN divisions on divisions.id = teams.division_id')
                 .joins('LEFT JOIN seasons on seasons.id = divisions.season_id')
                 .order('seasons.date_start DESC, divisions.sex, divisions.name, teams.name').paginate(page: params[:page])

    @total = @teams.total_entries
  end

  def show
    fetch_team

    add_breadcrumb @team.name, @team
  end

  def new
    @team = Team.new
    fetch_divisions

    add_breadcrumb "New", new_team_path
  end

  def create
    @team = Team.new(params[:team])
    fetch_divisions

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
    fetch_divisions

    add_breadcrumb @team.name, @team
    add_breadcrumb "Edit", edit_team_path(@team)
  end

  def update
    fetch_team
    fetch_divisions

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

  def fetch_divisions
    @divisions = Division.joins('LEFT JOIN seasons on seasons.id = divisions.season_id').order('seasons.date_start DESC, divisions.sex, divisions.name').paginate(page: params[:page])
  end
end
