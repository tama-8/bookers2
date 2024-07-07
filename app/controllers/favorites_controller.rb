class FavoritesController < ApplicationController


  def create
   @favorite = current_user.favorites.create(book_id: params[:book_id])
   @favorite.save
  #  redirect_back(fallback_location: root_path)
  redirect_to request.referer
  end

  def destroy
  @book = Book.find(params[:book_id])
  @favorite = current_user.favorites.find_by(user_id: current_user.id, book_id: params[:book_id])
   @favorite.destroy
  #  redirect_back(fallback_location: root_path)
  redirect_to request.referer
  end
end
