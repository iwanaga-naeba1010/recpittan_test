class AddyoutubeToRecreation < ActiveRecord::Migration[6.1]
  def change
    add_column :recreations, :youtube_id, :string
  end
end
