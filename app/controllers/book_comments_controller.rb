class BookCommentsController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]


    def create
      @book=Book.find(params[:book_id])
      @comment= current_user.book_comments.new(book_comment_params)
      @comment.book_id = @book.id
      @comment.save
    
      # unless @comment.save
      #   render 'error'
      # end
    end

    def destroy
       @book=Book.find(params[:book_id])
      @comment =BookComment.find(params[:id])
      @comment.destroy
        
    end

 
   private
    def book_comment_params
      params.require(:book_comment).permit(:content)
    end
end
