class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user
      #redirect_to user
       # redirect_back_or user unless user.level!=3
       #   redirect_to admin_console_path
       # end
       case user.level
       when 3
        then redirect_back_or user
      else
        redirect_to admin_console_index_path
         
       end
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to store_path
  end
end