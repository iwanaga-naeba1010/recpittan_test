class CreateCompanyMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :company_memos do |t|
      t.references :company, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
