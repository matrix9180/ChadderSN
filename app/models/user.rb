# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  display_name    :string           not null
#  email_address   :string           not null
#  password_digest :string           not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_username       (username) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :authored_posts, class_name: "Post", foreign_key: "author_id"

  has_many :follows_as_follower, class_name: "Follow", foreign_key: "user_id"
  has_many :follows_as_following, class_name: "Follow", foreign_key: "following_id"
  has_many :followers, through: :follows_as_following, source: :user
  has_many :followed_users, through: :follows_as_follower, source: :following
  has_many :followed_posts, through: :followed_users, source: :authored_posts

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post


  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
