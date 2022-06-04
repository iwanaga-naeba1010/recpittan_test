class DropEmailTemplateModel < ActiveRecord::Migration[7.0]
  def change
    drop_table :email_templates
  end
end
