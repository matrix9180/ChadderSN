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
    @like = Current.user.likes.build(post: @post)

    if @like.save
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@post.id}",
            partial: "shared/like_button",
            locals: { post: @post }
          )
        }
        format.html { redirect_to @post, notice: "Post liked successfully!" }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@post.id}",
            partial: "shared/like_button",
            locals: { post: @post }
          )
        }
        format.html { redirect_to @post, alert: @like.errors.full_messages.join(", ") }
      end
    end
  end

  def unlike
    @like = Current.user.likes.find_by(post: @post)

    if @like&.destroy
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@post.id}",
            partial: "shared/like_button",
            locals: { post: @post }
          )
        }
        format.html { redirect_to @post, notice: "Post unliked successfully!" }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@post.id}",
            partial: "shared/like_button",
            locals: { post: @post }
          )
        }
        format.html { redirect_to @post, alert: "You haven't liked this post." }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
