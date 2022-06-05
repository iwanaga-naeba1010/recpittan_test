class AddColumnEvaluationPublic < ActiveRecord::Migration[7.0]
  def change
    add_column :evaluations, :is_public, :boolean, default: true
  end
end
