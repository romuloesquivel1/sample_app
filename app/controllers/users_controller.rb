class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]  
  before_action :set_user, only: [:show, :destroy, :edit, :update, :followers, :following]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]
  before_action :set_per_page, only: [:index, :show]


  def index
    @users = User.activated.paginate(page: params[:page], per_page: @per_page)
  end

  def show
    redirect_to root_url and return unless @user.activated?
    @microposts = @user.microposts.paginate(page: params[:page], per_page: @per_page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else 
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'static_pages/user_not_found', status: :not_found
  end

  def set_per_page
    @per_page = params[:per_page] || 10
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end

  # Confirms the correct user.
  def correct_user
    set_user
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end