class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.text :summary
      t.string :photo_url
      t.integer :comments_count, default: 0
      t.text :body

      t.timestamps
    end
  end
end
