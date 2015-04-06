class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.references :user, index: true
      t.references :skill, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_skills, :users
    add_foreign_key :user_skills, :skills
  end
end
