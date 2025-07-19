class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :destroy, :like, :unlike ]

  def index
    @posts = Post.includes(:author)
                 .order(created_at: :desc)
                 .page(params[:page])
                 .per(20)
  end

  def show
  end

  def new
    @post = Current.user.authored_posts.build
  end

  def create
    @post = Current.user.authored_posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.author == Current.user
      @post.destroy
      redirect_to posts_path, notice: "Post was successfully deleted."
    else
      redirect_to @post, alert: "You can only delete your own posts."
    end
  end

  def like
    # TODO: Implement like functionality when likes table is added
    redirect_to @post, notice: "Like functionality coming soon!"
  end

  def unlike
    # TODO: Implement unlike functionality when likes table is added
    redirect_to @post, notice: "Unlike functionality coming soon!"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
