# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# 1000.times do 
# 	c = Category.new
# 	c.title = Faker::Commerce.department
# 	c.description =  Faker::Lorem.paragraph
# 	c.save
# end

category_ids =  Category.first(5).map(&:id)
user_ids = User.all.map(&:id)
1000.times do
	a = Article.new
	a.title = Faker::Book.title
	a.content = Faker::Lorem.paragraph
	# a.image_url = Faker::Avatar.image
  a.user_id = user_ids.sample
  a.category_id = category_ids.sample
  a.save
end