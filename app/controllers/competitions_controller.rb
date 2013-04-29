class CompetitionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @competitions = Competition.paginate(page: params[:page])
  end

  def show
    fetch_competition
  end

  def new
    @competition = Competition.new
  end

  def create
    @competition = Competition.new(params[:competition])

    if @competition.save
      flash[:success] = t(:competition_created)
      redirect_to @competition
    else
      render 'new'
    end
  end

  def edit
    fetch_competition
  end

  def update
    fetch_competition

    if @competition.update_attributes(params[:competition])
      flash[:success] = t(:competition_updated)
      redirect_to @competition
    else
      render 'edit'
    end
  end

  def destroy
    fetch_competition.destroy

    flash[:success] = t(:competition_deleted)
    redirect_to competitions_url
  end

  private # ----------------------------------------------------------

  def fetch_competition
    @competition = Competition.find(params[:id])
  end
end
