class AddFilenameToRecreationImage < ActiveRecord::Migration[7.0]
  def change
    add_column :recreation_images, :filename, :string
  end
end
