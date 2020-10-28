class BookComments < ActiveRecord::Migration[5.2]
  def change
  	drop_table :book_comments
  end
end
