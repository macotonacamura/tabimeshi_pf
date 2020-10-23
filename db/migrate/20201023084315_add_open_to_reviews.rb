class AddOpenToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :open, :time
    add_column :reviews, :close, :time
  end
end
