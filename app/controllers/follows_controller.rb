class FollowsController < ApplicationController
    def create
    @user_to_follow = User.find(params[:user_id])

    if @user_to_follow == Current.user
      redirect_to @user_to_follow, alert: "You cannot follow yourself."
      return
    end

    @follow = Current.user.follows_as_follower.build(following: @user_to_follow)

    if @follow.save
      redirect_to @user_to_follow, notice: "You are now following #{@user_to_follow.display_name}."
    else
      redirect_to @user_to_follow, alert: "Unable to follow user."
    end
  end

  def destroy
    @follow = Current.user.follows_as_follower.find_by(following_id: params[:user_id])

    if @follow
      @user_to_unfollow = @follow.following
      @follow.destroy
      redirect_to @user_to_unfollow, notice: "You have unfollowed #{@user_to_unfollow.display_name}."
    else
      redirect_to users_path, alert: "You are not following this user."
    end
  end
end
