# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(name:  "maachang",
             email: "maachang@gmail.com",
             password:              "p3ps1Cap",
             password_confirmation: "p3ps1Cap",
             admin: true)

User.create!(name:  "hoge",
             email: "hoge@gmail.com",
             password:              "hogehoge",
             password_confirmation: "hogehoge",
             admin: false)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               admin:false)
end