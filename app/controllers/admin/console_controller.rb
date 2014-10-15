class Admin::ConsoleController < Admin::BaseController

  before_action :signed_in_user, only: [:index]
  
  def index
    if current_user.level == 3
      redirect_to signed_in_user
    else
      @user = User.all
    end
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to consolelogin_url
    end
  end

end