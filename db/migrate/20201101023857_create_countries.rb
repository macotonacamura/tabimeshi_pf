class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :city_name
      t.string :currency
      t.string :code

      t.timestamps
    end
  end
end
