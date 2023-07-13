class CreateEvaluationReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluation_replies do |t|
      t.text :message, null: false
      t.references :evaluation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
