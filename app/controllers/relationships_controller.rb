class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:follow_id])
    following = current_user.follow(user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_back(fallback_location: :back)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: :back)
    end
  end

  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: :back)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: :back)
    end
  end

  def following_index
  	@user = User.find(params[:id])
  	@users = @user.followings
  end

  def follow_index
  	@user = User.find(params[:id])
  	@users = @user.followers
  end

end