class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.belongs_to :job, index: true
      t.belongs_to :client, index: true

      t.timestamps null: false
    end
    add_foreign_key :requests, :jobs
    add_foreign_key :requests, :users, column: :client_id
  end
end
