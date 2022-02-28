class ChangeRecreatioImageToRecreationFile < ActiveRecord::Migration[6.1]
  def change
    rename_table :recreation_images, :recreation_files
    rename_column :recreation_files, :image, :source
    add_column :recreation_files, :kind, :integer, default: 0
  end
end
