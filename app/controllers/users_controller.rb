class UsersController < ApplicationController

  before_action :signed_in_user,only: [:edit,:destroy,:show,:update]

  #layout "consolelayout", only: [:index, :show, :edit]
  
  def index
    render plain: "无权限"
  end


  def new
    @user=User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def create
    @user=User.new(user_params)
    @user.level=3
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
