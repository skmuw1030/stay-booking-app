class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "登録しました"
      redirect_to root_path
    else
      flash.now[:alert] ="登録に失敗しました"
      render :"new", status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(profile_params)
      flash[:notice] = "更新しました"
      redirect_to user_path(@user)
    else
      flash.now[:alert] ="更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def account
    @user = User.find(params[:id])
  end

  def edit_account
    @user = User.find(params[:id])
  end

  def update_account
    @user = User.find(params[:id])
    if @user.update(account_params)
      flash[:notice] = "アカウント情報を更新しました"
      redirect_to account_user_path(@user)
    else
      render :edit_account, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :user_image,
      :profile,
      :password,
      :password_confirmation
    )
  end

  private

  def profile_params
    params.require(:user).permit(
    :name,
    :email,
    :user_image,
    :profile
    )
  end
end
