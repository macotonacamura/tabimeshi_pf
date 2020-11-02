class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :review_id

      t.timestamps
      t.index [:user_id, :review_id], unique: true
    end
  end
end
