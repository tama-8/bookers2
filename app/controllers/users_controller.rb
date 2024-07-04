class UsersController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  # user詳細ページとbooks一覧を同じページで表示させる
  def show_with_books
  @user = User.find(params[:id])
  @books = @user.books
  end

  def edit

  @user = User.find(params[:id])
  end

  def index
     @user = current_user
    @books = @user.books
    @book = Book.new
    @users=User.all
    # @relationship = current_user.relationships.find(params[:id])
  end

  def update
    # 他のユーザーからのアクセスを制限
    is_matching_login_user

    @user = User.find(params[:id])
    @user_old_intrpduction = @user.introduction
    # @user.update(user_params)
    # redirect_to user_path(@user.id)
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      @updaited_user = @user.reload
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

   private

 def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
 end

 def is_matching_login_user
    user = User.find(params[:id])
   unless user.id == current_user.id
    redirect_to user_path(current_user.id)
   end
 end
end
