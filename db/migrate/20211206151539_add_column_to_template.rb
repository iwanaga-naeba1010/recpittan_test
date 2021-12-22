class AddColumnToTemplate < ActiveRecord::Migration[6.1]
  def change
    add_column :email_templates, :explanation, :string
    add_column :email_templates, :title, :string
    add_column :email_templates, :body, :text
    add_column :email_templates, :signature, :text
  end
end
