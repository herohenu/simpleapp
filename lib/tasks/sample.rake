namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    User.create!(name: "Admin User",
                 email: "abc@g.cn",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true
    )

    User.create!(name: "Example User",
                 email: "wo@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
  desc "Fill posts "
  task posts: :environment do
    users = User.all.limit(16)
    Micropost.delete_all
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end

  desc "make relationship"
  task relation: :environment do
    make_relationships
    puts 'make relation ship  ok --->!!'

  end


end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end