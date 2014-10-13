class Admin::ConsoleController < ApplicationController
  layout "consolelayout"
  before_action :signed_in_user,only: [:index,:edit,:destroy,:show,:update]

  

  def index
    if @current_user.level==3
      redirect_to signed_in_user
    else
    @user=User.all
    end
  end

  def login
    render layout: false
  end

  def logout
    sign_out
    redirect_to consolelogin_url
  end
  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to consolelogin_url
  end
end
end