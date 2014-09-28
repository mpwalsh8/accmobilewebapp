class Venue < ActiveRecord::Base
  validates_uniqueness_of :name, :presence => { :message => 'Venue name must be unique.' }
end
