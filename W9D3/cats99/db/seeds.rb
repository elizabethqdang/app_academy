# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all

cat1 = Cat.create!(name: 'Andy', birth_date: '2015/01/20', color: 'red', sex: 'm', description: 'cute cat with mustache')

cat2 = Cat.create!(name: 'Trevor', birth_date: '2000/01/01', color: 'green', sex: 'm', description: 'cute cat with a hat')
