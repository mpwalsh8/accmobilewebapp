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
  { name: 'Baseball', imageurl: 'pictograms/100x100/Baseball-Blk.png', active: false, resulttype: 'win-loss' },
  { name: 'Basketball', imageurl: 'pictograms/100x100/Basketball-Blk.png', active: false, resulttype: 'win-loss' },
  { name: 'Cheerleading', imageurl: 'pictograms/100x100/Cheerleading-Blk.png', active: false, resulttype: 'other' },
  { name: 'Cross Country', imageurl: 'pictograms/100x100/CrossCountry-Blk.png', active: false, resulttype: 'place' },
  { name: 'Diving', imageurl: 'pictograms/100x100/Diving-Blk.png', active: false, resulttype: 'place' },
  { name: 'Field Hockey', imageurl: 'pictograms/100x100/FieldHockey-Blk.png', active: false, resulttype: 'win-loss-tie' },
  { name: 'Football', imageurl: 'pictograms/100x100/Football-Blk.png', active: false, resulttype: 'win-loss-tie' },
  { name: 'Golf', imageurl: 'pictograms/100x100/Golf-Blk.png', active: false, resulttype: 'place' },
  { name: 'Gymnastics', imageurl: 'pictograms/100x100/Gymnastics-Blk.png', active: false, resulttype: 'place' },
  { name: 'Ice Hockey', imageurl: 'pictograms/100x100/IceHockey-Blk.png', active: false, resulttype: 'place' },
  { name: 'Indoor Track', imageurl: 'pictograms/100x100/IndoorTrack-Blk.png', active: false, resulttype: 'place' },
  { name: 'Lacrosse', imageurl: 'pictograms/100x100/Lacrosse-Blk.png', active: false, resulttype: 'win-loss-tie' },
  { name: 'Softball', imageurl: 'pictograms/100x100/Softball-Blk.png', active: false, resulttype: 'win-loss' },
  { name: 'Soccer', imageurl: 'pictograms/100x100/Soccer-Blk.png', active: false, resulttype: 'win-loss-tie' },
  { name: 'Sports Medicine', imageurl: 'pictograms/100x100/FirstAid-Blk.png', active: false, resulttype: 'none' },
  { name: 'Stunt', imageurl: 'pictograms/100x100/Gymnastics-Blk.png', active: false, resulttype: 'place' },
  { name: 'Swiming', imageurl: 'pictograms/100x100/Swimming-Blk.png', active: false, resulttype: 'place' },
  { name: 'Tennis', imageurl: 'pictograms/100x100/Tennis-Blk.png', active: false, resulttype: 'win-loss-tie' },
  { name: 'Track and Field', imageurl: 'pictograms/100x100/TrackFieldPoleVault-Blk.png', active: false, resulttype: 'place' },
  { name: 'Volleyball', imageurl: 'pictograms/100x100/Volleyball-Blk.png', active: false, resulttype: 'win-loss' },
  { name: 'Wrestling', imageurl: 'pictograms/100x100/Wrestling-Blk.png', active: false, resulttype: 'place' }
]

for sport in sports
  Sport.create!(sport)
end
