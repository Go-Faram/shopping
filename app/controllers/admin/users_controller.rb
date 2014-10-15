class Admin::UsersController < Admin::BaseController

  before_action :signed_in_user,only: [:index,:edit,:destroy,:show,:update]

  def index
    @users=User.all
    @newuser=User.new
  end

  def new
    @newuser=User.new
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
      redirect_to admin_users_path
    else
      redirect_to admin_users_path,notice: "添加用户失败"
    end
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:newuser).permit(:name,:email,:password,:password_confirmation,:level)
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
