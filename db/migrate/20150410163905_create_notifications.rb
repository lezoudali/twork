class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :kind
      t.belongs_to :sender, index: true
      t.belongs_to :user, index: true
      t.belongs_to :job, index: true
      t.belongs_to :request, index: true
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users, column_name: :sender_id
    add_foreign_key :notifications, :users
  end
end
