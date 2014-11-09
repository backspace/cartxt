class ChangeTxtBodyToText < ActiveRecord::Migration
  def change
    change_column :txts, :body, :text, limit: nil
  end
end
