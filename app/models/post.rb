# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  author_id  :bigint           not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_posts_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags

  validates :content, presence: true, length: { maximum: 1000 }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_user, ->(user) { where(author: user) }
  scope :with_hashtag, ->(hashtag) { joins(:hashtags).where(hashtags: { name: hashtag.downcase }) }

  before_save :process_hashtags

  def liked_by?(user)
    return false unless user
    likers.include?(user)
  end

  private

  def process_hashtags
    return unless content_changed?

    # Clear existing hashtags
    # post_hashtags.destroy_all

    # Extract hashtags from content (only at beginning or after whitespace)
    hashtag_names = content.scan(/(?:^|\s)#(\w+)/).flatten.map(&:downcase).uniq

    hashtags = []
    # Create or find hashtags and associate them
    hashtag_names.each do |name|
      hashtag = Hashtag.find_or_create_by(name: name)
      hashtags << hashtag
    end

    self.hashtags = hashtags
  end
end
