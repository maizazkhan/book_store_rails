# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'admin@bookstore.com', password: '12345678', role: :admin)
User.create!(email: 'manager@bookstore.com', password: '12345678', role: :manager)
User.create!(email: 'customer@bookstore.com', password: '12345678', role: :customer)
