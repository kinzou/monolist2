class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "会員登録が完了しました"
    else
      render 'new'
    end
  end
  
  def show
    @items = @user.items.group('items.id')
    @following_users_count = @user.following_users.count
    @follower_users_count = @user.followed_users.count
    @wnat_users_count = @user.want_items.count
    @have_users_count = @user.have_items.count
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
