require 'faker'

# Create users
3.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10),
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create List
10.times do
  List.create!(
  user:  users.sample,
  title: Faker::Lorem.sentence,
  )
end
lists = List.all

# Create tasks
100.times do
  Task.create!(
  list:  lists.sample,
  description:  Faker::Lorem.sentence,
  )
end

# Create my user
1.times do
me = User.new(
  name:     'Cole',
  email:    'combswc@gmail.com',
  password: 'password',
)
me.skip_confirmation!
me.save!
end

# Create my list
1.times do
  List.create!(
  user:  User.last,
  title: 'My Seeds Sample List',
  )
end

# Created my task
10.times do
  Task.create!(
  list:  List.last,
  description:  Faker::Lorem.sentence,
  )
end


puts "Seeds generation finished"
puts "#{User.count} users created"
puts "#{List.count} lists created"
puts "#{Task.count} tasks created"
