class RenameFileToImageToRecreationFile < ActiveRecord::Migration[6.1]
  def change
    rename_table :recreation_files, :recreation_images
    rename_column :recreation_images, :source, :image
  end
end
