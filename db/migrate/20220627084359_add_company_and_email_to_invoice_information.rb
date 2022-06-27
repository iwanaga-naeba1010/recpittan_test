class AddCompanyAndEmailToInvoiceInformation < ActiveRecord::Migration[7.0]
  def change
    add_column :invoice_informations, :company_name, :string, null: false
    add_column :invoice_informations, :email, :string, null: false
  end
end
