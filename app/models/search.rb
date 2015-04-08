class Search 
  attr_accessor :keyword

  def self.for(keyword)
    keyword.downcase!
    users  = User.where("lower(name) LIKE ?", "%#{keyword}%")
    jobs   = Job.where("lower(title) LIKE ?", "%#{keyword}%")
    skills = Skill.where("lower(name) LIKE ?", "%#{keyword}%")
    {users: users, jobs: jobs, skills: skills}
  end
end