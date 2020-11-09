class DropTableBookmarks < ActiveRecord::Migration[5.2]
  def change
  	drop_table :bookmarks
  end
end
