class CompetitionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Competitions", :competitions_path

  def index
    @competitions = Competition.paginate(page: params[:page])
  end

  def show
    fetch_competition

    add_breadcrumb @competition.name, @competition
  end

  def new
    @competition = Competition.new

    add_breadcrumb "New", new_competition_path
  end

  def create
    @competition = Competition.new(params[:competition])

    add_breadcrumb "New", new_competition_path

    if @competition.save
      flash[:success] = t(:competition_created)
      redirect_to @competition
    else
      render 'new'
    end
  end

  def edit
    fetch_competition

    add_breadcrumb @competition.name, @competition
    add_breadcrumb "Edit", edit_competition_path(@competition)
  end

  def update
    fetch_competition

    add_breadcrumb @competition.name, @competition
    add_breadcrumb "Edit", edit_competition_path(@competition)

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
