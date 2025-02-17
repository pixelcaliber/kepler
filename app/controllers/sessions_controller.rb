class SessionsController < ApplicationController
  def new
  end
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      flash[:success] = "Welcome to the Kepler!"
      log_in(@user)
      params[:session][:remember_me] ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  def destroy
    flash[:success] = 'You have been logged out.'
    log_out if logged_in?
    redirect_to root_path
  end
end
