class UsersController < ApplicationController
  before_filter :signed_in_user,      only: [:edit, :update, :index, :destroy]
  before_filter :signed_out_user,     only: [:new, :create]
  before_filter :user_is_current,     only: [:edit, :update]
  before_filter :user_is_not_current, only: [:destroy]
  before_filter :admin_user,          only: [:destroy]

  def show
    fetch_user
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      flash[:success] = t(:welcome, title: Settings.title)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
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
