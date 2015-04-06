class Request < ActiveRecord::Base
  belongs_to :job
  belongs_to :client, class_name: "User"
end
