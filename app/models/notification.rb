class Notification < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :user
  belongs_to :job
  belongs_to :request

  def to_s
    return "accepted your offer" if kind == "accepted"
    return "declined your offer" if kind == "declined"
    return "sent you an offer" if kind == "offer"
  end
end
