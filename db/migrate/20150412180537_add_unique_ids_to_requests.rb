class AddUniqueIdsToRequests < ActiveRecord::Migration
  def change
    add_index :requests, [:client_id, :job_id], unique: true
  end
end
