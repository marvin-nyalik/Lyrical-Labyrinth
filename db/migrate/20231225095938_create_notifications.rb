class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :action
      t.integer :notifiable_id
      t.string :notifiable_type
      t.boolean :read, default: false

      t.timestamps
    end

    add_index :notifications, [:notifiable_id, :notifiable_type], name: 'index_notifications_on_notifiable'
  end
end
