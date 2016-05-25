# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# reset all
p 'Clearing data..'
User.destroy_all
Question.destroy_all
Answer.destroy_all
Vote.destroy_all
Comment.destroy_all
Tag.destroy_all
Badge.destroy_all
Bookmark.destroy_all

p 'Creating sample data..'
# Create sample data
user = User.first_or_create!(
  password: "password",
  email: "testuser@email.com",
  username: "test_user"
)
user.user_badges.create!(badge_id: rand(1..3))

question_1 = Question.create!(title: Faker::Lorem.sentence, text: Faker::Lorem.sentence, user_id: user.id)
question_2 = Question.create!(title: Faker::Lorem.sentence, text: Faker::Lorem.sentence, user_id: user.id)
question_3 = Question.create!(title: Faker::Lorem.sentence, text: Faker::Lorem.sentence, user_id: user.id)

user.bookmarks.create!(bookmarkable: question_1)
user.bookmarks.create!(bookmarkable: question_2)
user.bookmarks.create!(bookmarkable: question_3)

Badge.create!(
  id: 1,
  name: 'Mentor',
  rank: 1,
  required_points: 3,
  color_hex: '#27ae60'
)

Badge.create!(
  id: 2,
  name: 'Master',
  rank: 2,
  required_points: 10,
  color_hex: '#2980b9'
)

Badge.create!(
  id: 3,
  name: 'Supreme Master',
  rank: 3,
  required_points: 20,
  color_hex: '#34495e'
)

5.times do
  user = User.create!(username: Faker::Internet.user_name, password: "password", email: Faker::Internet.email)
end

3.times do |i|
  user = User.create!(username: Faker::Internet.user_name, password: "password", email: Faker::Internet.email)
  user.user_badges.create!(badge_id: rand(1..3))
  question = Question.create!(title: Faker::Lorem.sentence, text: Faker::Lorem.sentence, user_id: user.id)
  5.times do |i|
    question.tags.create!(text: Faker::Lorem.word )
  end
  answer = question.answers.create!(text: Faker::Lorem.sentence, user_id: user.id)
  answer.comments.create!(text: Faker::Lorem.sentence, user: user)
  rand(5).times do |i|
    answer.votes.create!(user: User.all[i])
  end
end
