class AddPrefCodeToPartnerInfos < ActiveRecord::Migration[7.2]
  def change
    add_column :partner_infos, :pref_code, :string, null: true
  end
end
