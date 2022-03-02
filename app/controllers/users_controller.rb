class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @pagy, @user = pagy User.all, items: Settings.settings.paging_numbers
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t("success")
      redirect_to @user
    else
      flash.now[:danger] = t("fail_to_create")
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = t("profile_updated")
      redirect_to @user
    else
      flash.now[:danger] = t("fail_to_update")
      render :edit
    end
  end

  def destroy
    if @user&.destroy
      flash[:success] = t("user_deleted")
    else
      flash[:danger] = t("delete_fail")
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    store_location

    flash[:danger] = t("please_log_in")

    redirect_to login_url
  end

  def correct_user
    redirect_to(root_url) unless current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_found"
    redirect_to help_path
  end
end
