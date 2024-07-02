class BookCommentsController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]


    def create
      @book=Book.find(params[:book_id])
      @book_comment= current_user.book_comments.new(book_comment_params)
      @book_comment.book_id = @book.id

      if @book_comment.save
        redirect_to book_path(@book.id)
      else
        render book_pash

      end
    end

    def destroy
      @book =Book.find(params[:book_id])
      book_comment=@book.book_coments.find(params[:id])
      if current_user.id == book_comment.user.id
        book_comment.destroy
      redirect_back(fallback_location: root_path)
      else
        render "book/show"
      end
    end

    def book_comment_params
      params.require(:book_comment).permit(:content)
    end
end
