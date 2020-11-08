class AddCountriesToContinentId < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :continent_id, :integer
  end
end
