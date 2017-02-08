class SessionsController < ApplicationController
  def new
  end
  def create
    if User.exists?(email: params[:session][:email].downcase)
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user #function defined in session_helper.rb
        redirect_back_or user
      else
        render 'new'
        flash[:danger] = "Invalid email/password combination"
      end
    else
      redirect_to signup_path
      flash[:danger] = "Please register first!"
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
