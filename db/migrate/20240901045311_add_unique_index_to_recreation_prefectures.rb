class AddUniqueIndexToRecreationPrefectures < ActiveRecord::Migration[7.0]
  def change
    change_column_null :recreation_prefectures, :name, false
    add_index :recreation_prefectures, [:name, :recreation_id], unique: true, name: 'index_recreation_prefectures_on_name_and_recreation_id'
  end
end
