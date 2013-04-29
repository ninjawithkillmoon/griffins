class DivisionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @divisions = Division.paginate(page: params[:page])
  end

  def show
    fetch_division
  end

  def new
    @division = Division.new
  end

  def create
    @division = Division.new(params[:division])

    if @division.save
      flash[:success] = t(:division_created)
      redirect_to @division
    else
      render 'new'
    end
  end

  def edit
    fetch_division
  end

  def update
    fetch_division

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
end
