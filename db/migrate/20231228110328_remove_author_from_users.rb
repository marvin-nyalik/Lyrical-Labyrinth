class RemoveAuthorFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :author, :boolean
  end
end
