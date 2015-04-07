class Search 
  attr_accessor :keyword

  def self.for(keyword)
    keyword.downcase!
    users  = User.where("lower(name) LIKE ?", "%#{keyword}%")
    jobs   = Job.where("title LIKE ?", "%#{keyword}%")
    skills = Skill.where("name LIKE ?", "%#{keyword}%")
    {users: users, jobs: jobs, skills: skills}
  end
end