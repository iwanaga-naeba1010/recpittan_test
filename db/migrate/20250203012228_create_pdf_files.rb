class CreatePdfFiles < ActiveRecord::Migration[7.2]
  def change
    create_table :pdf_files do |t|
      t.string :file

      t.timestamps
    end
  end
end
