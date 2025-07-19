class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :show, :index ]
  before_action :set_user, only: [ :show, :followers, :following ]

  def index
    @users = User.order(:display_name)
                 .page(params[:page])
                 .per(20)
  end

    def show
    @posts = @user.authored_posts
                  .order(created_at: :desc)
                  .page(params[:page])
                  .per(10)

    @is_following = Current.user&.followed_users&.include?(@user)
  end

  def followers
    @followers = @user.followers
                      .order(:display_name)
                      .page(params[:page])
                      .per(20)
  end

  def following
    @following = @user.followed_users
                      .order(:display_name)
                      .page(params[:page])
                      .per(20)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
