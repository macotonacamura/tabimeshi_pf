class AddIndexToCitiesCity < ActiveRecord::Migration[5.2]
  def change
  	add_index :cities, :city
  end
end
