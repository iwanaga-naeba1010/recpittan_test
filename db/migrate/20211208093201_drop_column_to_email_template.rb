class DropColumnToEmailTemplate < ActiveRecord::Migration[6.1]
  def change
    remove_column :email_templates, :type
    add_column :email_templates, :kind, :integer
  end
end
