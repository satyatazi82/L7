class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render 'new'
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by(email: email)

    if (user && user.authenticate(password))
      session[:current_user_id] = user.id
      redirect_to "/"
    elsif
      flash[:error] = "Your sigin attempt was invalid. Please try again!"
      redirect_to signin_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
