class BooksController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books=@user.books
    @new_book = Book.new
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new

  end

  def edit
   # 他のユーザーからのアクセスを制限
   is_matching_login_user

  @book = Book.find(params[:id])
  end

  def update
    # 他のユーザーからのアクセスを制限
    is_matching_login_user

    @book = Book.find(params[:id])
    # @book.update(book_params)
    # redirect_to book_path(@book.id)
    if @book.update(book_params)
      flash[:notice] = "You have updated user successfully."
       redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    @books =Book.all
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
       flash[:notice] ="You have created book successfully."
    # 4. トップ画面へリダイレクト
    else
      @user = current_user
      render :index

    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end



  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
  book = Book.find(params[:id])
  redirect_to books_path unless book.user_id == current_user.id
  end

end
