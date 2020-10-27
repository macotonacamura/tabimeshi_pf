class RenameMuximunBudgetToReviews < ActiveRecord::Migration[5.2]
  def change
  	rename_column :reviews, :muximum_budget, :maximum_budget
  end
end
