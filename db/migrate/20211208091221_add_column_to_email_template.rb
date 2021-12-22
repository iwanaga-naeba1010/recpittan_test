class AddColumnToEmailTemplate < ActiveRecord::Migration[6.1]
  def change
    add_column :email_templates, :type, :string
  end
end
