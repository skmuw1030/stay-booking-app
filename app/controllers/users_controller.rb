class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
    if @user.update(user_params)
      flash[:notice] = "スケジュールを更新しました"
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
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
end
