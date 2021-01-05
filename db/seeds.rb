# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FeatureFlag.create({ name: 'IntroductionForUsers', description: 'Feature flag to enable an introduction for users upon login' })
Role.create([{ name: 'A' }, { name: 'B' }])