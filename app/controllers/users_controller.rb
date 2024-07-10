class UsersController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    #投稿数
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    #DM機能
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu| 
        @userEntry.each do |u| 
          if cu.room_id == u.room_id 
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
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
