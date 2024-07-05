class RelationshipsController < ApplicationController

  before_action :authenticate_user!
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    #redirect_to request.referer
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    #redirect_to  request.referer
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
