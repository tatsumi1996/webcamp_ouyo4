class RelationshipsController < ApplicationController
def follow
  current_user.follow(params[:id])
  redirect_back(fallback_location: root_path)
end

def unfollow
  current_user.unfollow(params[:id])
  redirect_back(fallback_location: root_path)
end

def followings
  user = User.find(params[:user_id])
  @users = user.following_user
end

def followers
  user = User.find(params[:user_id])
  @users = user.follower_user
end

end
