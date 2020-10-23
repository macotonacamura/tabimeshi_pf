class RenameProfileImageIdColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	 rename_column :users, :profile_image_id, :profile_image
  end
end
