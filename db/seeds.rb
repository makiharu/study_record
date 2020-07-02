# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@test.com',
  password: 'password'
)

# 50persons
50.times do |n|
  name = Faker::Name.name
  email = "example#{n}@gmail.com"
  is_deleted = Faker::Boolean.boolean

  User.create!(
    name: name,
    email: email,
    password: 'password',
    is_deleted: is_deleted
  )
end

# tag_list
Tag.create([
             { name: 'HTML & CSS' },
             { name: 'JavaScript' },
             { name: 'jQuery' },
             { name: 'Ruby' },
             { name: 'Ruby on Rails' },
             { name: 'PHP' },
             { name: 'Java' },
             { name: 'Python' },
             { name: 'Command Line' },
             { name: 'Git' },
             { name: 'SQL' },
             { name: 'Sass' },
             { name: 'React' },
             { name: 'Node.js' },
             { name: 'その他' }
           ])



if Rails.env == 'development'

  # 50boards
  50.times do |n|
    user_id = rand(1..50)
    title = Faker::Games::Pokemon.name
    body = "質問内容です。質問内容です。質問内容です。答えてください。答えてください。答えてください。
            質問内容です。質問内容です。質問内容です。答えてください。答えてください。答えてください。
            質問内容です。質問内容です。質問内容です。答えてください。答えてください。答えてください。
            質問内容です。質問内容です。質問内容です。答えてください。答えてください。答えてください。
            質問内容です。質問内容です。質問内容です。答えてください。答えてください。答えてください。
            質問内容です。質問内容です。質問内容です。答えてください。答えてください。答えてください。"

    Board.create!(
      user_id: user_id,
      title: title,
      body: body
    )
  end
end
