class RemoveSlugFromTags < ActiveRecord::Migration[7.1]
  def change
    remove_column :tags, :slug, :string
  end
end
