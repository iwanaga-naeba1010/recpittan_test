class AddUniqueIndexToEvaluationIdInEvaluationReplies < ActiveRecord::Migration[6.1]
  def change
    remove_index :evaluation_replies, :evaluation_id if index_exists?(:evaluation_replies, :evaluation_id)
    add_index :evaluation_replies, :evaluation_id, unique: true
  end
end
