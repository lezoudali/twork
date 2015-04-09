class AddCompletedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :completed, :boolean, default: false
  end
end
