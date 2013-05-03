class UsersController < ApplicationController
  before_filter :signed_in_user,      only: [:edit, :update, :index, :destroy]
  before_filter :signed_out_user,     only: [:new, :create]
  before_filter :user_is_current,     only: [:edit, :update]
  before_filter :user_is_not_current, only: [:destroy]
  before_filter :admin_user,          only: [:destroy]

  add_breadcrumb "Users", :users_path, only: [:index, :show, :edit, :update, :destroy]

  def show
    fetch_user

    add_breadcrumb @user.name, @user
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new

    add_breadcrumb "Sign Up", new_user_path
  end

  def create
    @user = User.new(params[:user])

    add_breadcrumb "Sign Up", new_user_path

    if @user.save
      sign_in @user
      flash[:success] = t(:welcome, title: Settings.title)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    fetch_user

    add_breadcrumb @user.name, @user
    add_breadcrumb "Edit", edit_user_path(@user)
  end

  def update
    fetch_user

    add_breadcrumb @user.name, @user
    add_breadcrumb "Edit", edit_user_path(@user)

    if @user.update_attributes(params[:user])
      flash[:success] = t(:profile_updated)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    fetch_user.destroy

    flash[:success] = t(:user_deleted)
    redirect_to users_url
  end

  private # ---------------------------------------------------------------------------

  def fetch_user
    @user = User.find(params[:id])
  end

  # Checks that the current signed in user is the same as the one being operated on (from params).
  #
  # Redirects to root with an error message if not, otherwise: continue the operation.
  #
  def user_is_current
    fetch_user

    unless current_user?(@user)
      flash[:error] = t(:not_authorized)
      redirect_to root_path
    end
  end

  def user_is_not_current
    fetch_user

    if current_user?(@user)
      flash[:error] = t(:not_authorized)
      redirect_to @user
    end
  end
end
