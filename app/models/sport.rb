class Sport < ActiveRecord::Base
  validates :name, :presence => { :message => 'Name must be specified.' }
  validates :imageurl, :presence => { :message => 'Image must be specified.' }
  validates :resulttype, :presence => { :message => 'Result Type must be specified.' }
end
