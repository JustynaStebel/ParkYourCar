class SessionController < ApplicationController

  def new
    store_referrer_location if session[:return_to].blank?
  end

  def create
    account = Account.authenticate(params[:email], params[:password])
    if account
      session[:user_id] = account.user.id
      flash[:success] = "You have successfully logged in."
      redirect_to session[:return_to] || root_path
    else
      flash[:danger] = "Wrong email or password!"
      redirect_to action: 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
