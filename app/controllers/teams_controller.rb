class TeamsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @teams = Team.paginate(page: params[:page])
  end

  def show
    fetch_team
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      flash[:success] = t(:team_created)
      redirect_to @team
    else
      render 'new'
    end
  end

  def edit
    fetch_team
  end

  def update
    fetch_team

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
