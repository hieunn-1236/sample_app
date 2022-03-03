User.create!(name: "Example User",
             email: "example@email.com",
             password: "demo12345",
             password_confirmation: "demo12345",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@email.com"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
  end
