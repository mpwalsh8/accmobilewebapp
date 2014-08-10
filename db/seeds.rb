# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html


#  Seed the Sports table
Sport.delete_all

sports = [
  { name: 'Baseball', imageurl: '/assets/pictograms/100x100/Baseball-Blk.png', active: false },
  { name: 'Basketball', imageurl: '/assets/pictograms/100x100/Basketball-Blk.png', active: false },
  { name: 'Cheerleading', imageurl: '/assets/pictograms/100x100/Cheerleading-Blk.png', active: false },
  { name: 'Cross Country', imageurl: '/assets/pictograms/100x100/CrossCountry-Blk.png', active: false },
  { name: 'Diving', imageurl: '/assets/pictograms/100x100/Diving-Blk.png', active: false },
  { name: 'Field Hockey', imageurl: '/assets/pictograms/100x100/FieldHockey-Blk.png', active: false },
  { name: 'Football', imageurl: '/assets/pictograms/100x100/Football-Blk.png', active: false },
  { name: 'Golf', imageurl: '/assets/pictograms/100x100/Golf-Blk.png', active: false },
  { name: 'Gymnastics', imageurl: '/assets/pictograms/100x100/Gymnastics-Blk.png', active: false },
  { name: 'Ice Hockey', imageurl: '/assets/pictograms/100x100/IceHockey-Blk.png', active: false },
  { name: 'Indoor Track', imageurl: '/assets/pictograms/100x100/IndoorTrack-Blk.png', active: false },
  { name: 'Lacrosse', imageurl: '/assets/pictograms/100x100/Lacrosse-Blk.png', active: false },
  { name: 'Softball', imageurl: '/assets/pictograms/100x100/Softball-Blk.png', active: false },
  { name: 'Soccer', imageurl: '/assets/pictograms/100x100/Soccer-Blk.png', active: false },
  { name: 'Sports Medicine', imageurl: '/assets/pictograms/100x100/FirstAid-Blk.png', active: false },
  { name: 'Stunt', imageurl: '/assets/pictograms/100x100/Gymnastics-Blk.png', active: false },
  { name: 'Swiming', imageurl: '/assets/pictograms/100x100/Swimming-Blk.png', active: false },
  { name: 'Tennis', imageurl: '/assets/pictograms/100x100/Tennis-Blk.png', active: false },
  { name: 'Track and Field', imageurl: '/assets/pictograms/100x100/TrackFieldPoleVault-Blk.png', active: false },
  { name: 'Volleyball', imageurl: '/assets/pictograms/100x100/Volleyball-Blk.png', active: false },
  { name: 'Wrestling', imageurl: '/assets/pictograms/100x100/Wrestling-Blk.png', active: false }
]

for sport in sports
  Sport.create!(sport)
end
