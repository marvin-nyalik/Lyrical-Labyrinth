class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :post, index: true, foreign_key: true
      t.integer :author_id

      t.timestamps
    end
  end
end
