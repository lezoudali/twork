20.times do
  u = User.create(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    provider: "twitter", 
    uid: Faker::Number.number(3)
  )
  u.jobs.build(title: "Make me a #{Faker::Hacker.noun}", description: Faker::Lorem.sentence)
  u.jobs.build(title: "Paint my #{Faker::Hacker.noun}", description: Faker::Lorem.sentence)
  u.save
end