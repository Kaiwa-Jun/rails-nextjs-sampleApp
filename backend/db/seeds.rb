# db/seeds.rb

require 'faker'

# 1. ユーザー作成
User.delete_all
admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)
puts "Created Admin User: #{admin.email}"

# 他のユーザーを 5 人ほど作成
5.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password'
  )
  puts "Created User: #{user.email}"
end

# 2. 投稿作成
Post.delete_all
users = User.all

20.times do
  post = Post.create!(
    title:       Faker::Lorem.sentence(word_count: 3),
    image_url:   "https://placehold.jp/150x150.png",
    description: Faker::Lorem.paragraph(sentence_count: 2),
    user:        users.sample
  )
  puts "Created Post: #{post.title} by #{post.user.email}"
end