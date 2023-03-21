class CreateChannelPlanSubscribers < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_plan_subscribers do |t|
      t.integer :kind
      t.integer :status, default: 0
      t.references :company, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
