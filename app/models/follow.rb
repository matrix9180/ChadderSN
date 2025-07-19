# == Schema Information
#
# Table name: follows
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  following_id  :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_follows_on_following_id  (following_id)
#  index_follows_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (following_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User"

  validates :user_id, uniqueness: { scope: :following_id, message: "You are already following this user" }
  validate :cannot_follow_self

  private

  def cannot_follow_self
    if user_id == following_id
      errors.add(:base, "You cannot follow yourself")
    end
  end
end
