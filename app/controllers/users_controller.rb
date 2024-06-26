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

  # def create
  #   # １. データを受け取り新規登録するためのインスタンス作成
  #   @user = User.new(_params)
  #   # 2. データをデータベースに保存するためのsaveメソッド実行
  #   if @user.save
  #     # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
  #     redirect_to user_path(@user.id)
  #     flash[:notice] = "投稿に成功しました。"
  #   else
  #     render :root_pash
  #   end
  # end

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
