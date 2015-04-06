class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.references :contractor, index: true

      t.timestamps null: false
    end
    add_foreign_key :jobs, :users, column: :contractor_id
  end
end
