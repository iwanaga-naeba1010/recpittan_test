class AddIsWithholdingTaxToRecreations < ActiveRecord::Migration[7.2]
  def change
    add_column :recreations, :is_withholding_tax, :boolean, default: false, null: true
  end
end
