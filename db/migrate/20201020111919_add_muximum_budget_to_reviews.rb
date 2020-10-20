class AddMuximumBudgetToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :muximum_budget, :integer
  end
end
