class AddColumnsToRecreation < ActiveRecord::Migration[6.1]
  def change
    add_column :recreations, :flyer_color, :string
    # NOTE: いつか直したい
    add_column :recreations, :prefectures, :string, array: true, default: []
    add_column :recreations, :regular_price, :integer
    add_column :recreations, :regular_material_price, :integer
    add_column :recreations, :instructor_material_amount, :integer
    add_column :recreations, :capacity, :integer
    add_column :recreations, :instructor_amount, :integer
    add_column :recreations, :instructor_position, :string
    add_column :recreations, :is_public, :boolean
  end
end
