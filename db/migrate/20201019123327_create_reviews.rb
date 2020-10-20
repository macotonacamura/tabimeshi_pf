class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :restaurant_name
      t.text :review
      t.float :rate , default: 0
      t.integer :budget
      t.string :image_id
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
