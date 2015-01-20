class UsersController < ApplicationController
  
  before_action :logged_in?, except: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def profile
    redirect_to user_path(current_user)
  end

  def create
    user = User.new(user_params)
    if user.save
      login user
      redirect_to profile_path
    else
      redirect_to sign_up_path
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by({id: params[:id]})
    @articles = @user.articles
  end

  def edit
  end

  def update
    @user = @user.update_attributes(user_params)
    if @user
      redirect_to profile_path
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def destroy
    @user.destroy()
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      white_list = [
                    :email, :email_confirmation,
                    :password, :password_confirmation,
                    :first_name, :last_name
                  ]
      params.require(:user).permit(*white_list)
    end
end
