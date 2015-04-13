20.times do
  u = User.create(
    first_name: Faker::Name.name, 
    last_name: Faker::Name.name,
    email: Faker::Internet.email, 
    provider: "twitter", 
    uid: Faker::Number.number(3)
  )
  u.jobs.build(title: "Make me a #{Faker::Hacker.noun}", description: Faker::Lorem.sentence)
  u.jobs.build(title: "Paint my #{Faker::Hacker.noun}", description: Faker::Lorem.sentence)
  u.save
end

10.times {Skill.create(name: Faker::Hacker.ingverb)}