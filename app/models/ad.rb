class Ad < ActiveRecord::Base
  validates :name, :presence => { :message => 'Name must be specified.' }
  validates :imageurl, :presence => { :message => 'Image URL must be specified.' }
  validates :clickurl, :presence => { :message => 'Click URL must be specified.' }
  validates :adtype, :presence => { :message => 'Ad Type must be specified.' }
end
