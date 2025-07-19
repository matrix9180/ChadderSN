class HashtagsController < ApplicationController
  def index
    @hashtags = Hashtag.popular.limit(50)
  end

  def show
    @hashtag = Hashtag.find_by!(name: params[:name].downcase)
    @posts = Post.with_hashtag(@hashtag.name)
                 .includes(:author, :hashtags, :likes)
                 .order(created_at: :desc)
                 .page(params[:page])
                 .per(20)
  end
end
