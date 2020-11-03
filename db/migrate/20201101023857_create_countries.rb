class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :country
      t.string :city
      t.string :currency
      t.string :code
      t.integer :review_id

      t.timestamps
    end
  end
end
