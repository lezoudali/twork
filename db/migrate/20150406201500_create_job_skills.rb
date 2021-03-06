class CreateJobSkills < ActiveRecord::Migration
  def change
    create_table :job_skills do |t|
      t.references :job, index: true
      t.references :skill, index: true

      t.timestamps null: false
    end
    add_foreign_key :job_skills, :jobs
    add_foreign_key :job_skills, :skills
  end
end
