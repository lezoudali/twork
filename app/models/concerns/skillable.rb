module Skillable
  def add_new_skills(skill_names)
    skill_names.each do |skill_name|
      skills = Skill.where("lower(name) = ?", skill_name.downcase)
      skill = skills.empty? ? Skill.create(name: skill_name.downcase) : skills.first
      self.skills << skill unless self.skills.include? skill
    end
  end
end