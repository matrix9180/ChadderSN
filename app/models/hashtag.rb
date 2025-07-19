# == Schema Information
#
# Table name: hashtags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_hashtags_on_name  (name) UNIQUE
#
class Hashtag < ApplicationRecord
  has_many :post_hashtags, dependent: :destroy
  has_many :posts, through: :post_hashtags

  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }

  before_validation :normalize_name

  scope :popular, -> { joins(:post_hashtags).group(:id).order("COUNT(post_hashtags.id) DESC") }

  def to_param
    name
  end

  private

  def normalize_name
    self.name = name&.downcase&.strip
  end
end
