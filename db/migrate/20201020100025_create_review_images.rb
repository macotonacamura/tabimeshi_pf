class CreateReviewImages < ActiveRecord::Migration[5.2]
  def change
    create_table :review_images do |t|
      t.integer :review_id
      t.string :image

      t.timestamps
    end
  end
end
