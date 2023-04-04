class CreateChannelPlanSubscriberMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_plan_subscriber_memos do |t|
      t.references :channel_plan_subscriber, null: false, foreign_key: true, index: {name: :index_subscriber_memos_on__subscriber_id}
      t.text :body

      t.timestamps
    end
  end
end
