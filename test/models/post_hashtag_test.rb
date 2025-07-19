# == Schema Information
#
# Table name: post_hashtags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hashtag_id :bigint           not null
#  post_id    :bigint           not null
#
# Indexes
#
#  index_post_hashtags_on_hashtag_id              (hashtag_id)
#  index_post_hashtags_on_post_id                 (post_id)
#  index_post_hashtags_on_post_id_and_hashtag_id  (post_id,hashtag_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (hashtag_id => hashtags.id)
#  fk_rails_...  (post_id => posts.id)
#
require "test_helper"

class PostHashtagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
