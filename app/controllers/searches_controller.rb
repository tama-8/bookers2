class SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.looks(params[:search],params[:word])
    else  @range == "Book"
      @books = Book.looks(params[:search],params[:word])
    end
    # respond_to do |format|
    # format.html { render 'search_result' }
    end
  end

