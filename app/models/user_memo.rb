# frozen_string_literal: true

# == Schema Information
#
# Table name: user_memos
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_memos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserMemo < ApplicationRecord
  belongs_to :user, class_name: 'User'
end
