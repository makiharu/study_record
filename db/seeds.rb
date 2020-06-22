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


50.times do |n|
	name = Faker::Name.name
	email = "example#{n}@gmail.com"
	is_deleted = Faker::Boolean.boolean

	user = User.create!(
		name: name,
		email: email,
		password: 'password',
		is_deleted: is_deleted
)

end