class SpareUniformsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Spare Uniforms", :spare_uniforms_path

  def index
    @spare_uniforms = SpareUniform.order(:number).paginate(page: params[:page])

    @total = @spare_uniforms.total_entries
  end

  def show
    fetch_spare_uniform

    add_breadcrumb @spare_uniform.number, @spare_uniform
  end

  def new
    @spare_uniform = SpareUniform.new

    add_breadcrumb "New", new_spare_uniform_path
  end

  def create
    @spare_uniform = SpareUniform.new(params[:spare_uniform])

    add_breadcrumb "New", new_spare_uniform_path

    if @spare_uniform.save
      flash[:success] = t(:spare_uniform_created)
      redirect_to @spare_uniform
    else
      render 'new'
    end
  end

  def edit
    fetch_spare_uniform

    add_breadcrumb @spare_uniform.number, @spare_uniform
    add_breadcrumb "Edit", edit_spare_uniform_path(@spare_uniform)
  end

  def update
    fetch_spare_uniform

    add_breadcrumb @spare_uniform.number, @spare_uniform
    add_breadcrumb "Edit", edit_spare_uniform_path(@spare_uniform)

    if @spare_uniform.update_attributes(params[:spare_uniform])
      flash[:success] = t(:spare_uniform_updated)
      redirect_to @spare_uniform
    else
      render 'edit'
    end
  end

  def destroy
    fetch_spare_uniform.destroy

    flash[:success] = t(:spare_uniform_deleted)
    redirect_to spare_uniforms_url
  end

  private # ----------------------------------------------------------

  def fetch_spare_uniform
    @spare_uniform = SpareUniform.find(params[:id])
  end
end
