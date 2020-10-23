class RemoveImageIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :image_id, :string
  end
end
