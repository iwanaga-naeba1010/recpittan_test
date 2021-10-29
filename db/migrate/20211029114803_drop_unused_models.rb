class DropUnusedModels < ActiveRecord::Migration[6.1]
  def change
    drop_table :recreation_targets
    drop_table :targets
  end
end
