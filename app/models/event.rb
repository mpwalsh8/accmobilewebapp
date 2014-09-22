class Event < ActiveRecord::Base
  serialize :opponents
  validates :status, :presence => { :message => 'Status must be specified.' }
  validates :venueid, :presence => { :message => 'Venue must be specified.' }
  validates :eventlocation, :presence => { :message => 'Location must be specified.' }
  validates :eventdate, :presence => { :message => 'Event Date is required.' }
  validates :eventtime, :presence => { :message => 'Event Time is required.' }
  validates_format_of :eventdate, :message => 'Date must be YYYY-MM-DD format.', :with => /(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])/
  validates_format_of :eventtime, :message => 'Time must be HH:MM format.', :with => /([01]?[0-9]|2[0-3]):[0-5][0-9]/


  #has_and_belongs_to_many :teams, through: :events
  #has_and_belongs_to_many :opponents, through: :events

  def datetime
    dt = DateTime.parse(sprintf("%s %s", eventdate, eventtime))
    dt.strftime("%b %-d %Y @ %l:%M %p")
  end

  def datetimeshort
    dt = DateTime.parse(sprintf("%s %s", eventdate, eventtime))
    dt.strftime("%m/%-d/%Y")
  end

  def datetimelong
    dt = DateTime.parse(sprintf("%s %s", eventdate, eventtime))
    dt.strftime("%A, %B %-d %Y at %l:%M %p")
  end
end
