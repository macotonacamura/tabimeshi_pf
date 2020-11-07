class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :city
      t.integer :country_id

      t.timestamps
    end
  end
end
