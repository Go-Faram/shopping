class UsersController < ApplicationController

  before_action :signed_in_user,only: [:index,:edit,:destroy,:show,:update]

  layout "consolelayout", only: [:index, :show, :edit]
  
  def index
    @users=User.all

  end

  def new
    @user=User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def update

  end

  def edit
    @user=User.find(params[:id])
  end

  def create
    @user=User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to store_index_path
    else
      render 'new'
    end
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:level)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
