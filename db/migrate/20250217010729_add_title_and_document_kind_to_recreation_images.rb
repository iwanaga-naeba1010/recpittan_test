class AddTitleAndDocumentKindToRecreationImages < ActiveRecord::Migration[7.2]
  def change
    add_column :recreation_images, :title, :string, null: true
    add_column :recreation_images, :document_kind, :string, null: true
  end
end
