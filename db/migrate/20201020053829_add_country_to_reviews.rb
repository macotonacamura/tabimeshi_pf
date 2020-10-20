class AddCountryToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :country, :string
    add_column :reviews, :city, :string
  end
end
