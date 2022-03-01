class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      if @user.activated?
        login_remember @user
      else
        flash[:warning] = t "acount_not_activated"
        redirect_to root_path
      end
    else
      flash.now[:danger] = t ".invalid_user"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
  def find_user
    @user = User.find_by email: params[:session][:email].downcase
  end
end
