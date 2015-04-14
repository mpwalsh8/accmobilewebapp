class Event < ActiveRecord::Base
  serialize :opponents
  validates :status, :presence => { :message => 'Status must be specified.' }
  validates :venueid, :presence => { :message => 'Venue must be specified.' }
  validates :eventlocation, :presence => { :message => 'Location must be specified.' }
  validates :eventdate, :presence => { :message => 'Event Date is required.' }
  validates :eventtime, :presence => { :message => 'Event Time is required.' }
  validates_format_of :eventdate, :message => 'Date must be YYYY-MM-DD format.', :with => /(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])/
  validates_format_of :eventtime, :message => 'Time must be HH:MM format.', :with => /([01]?[0-9]|2[0-3]):[0-5][0-9]/
  validates_uniqueness_of :teamid, :scope => [ :eventdate, :eventtime ], :message => 'Event cannot be scheduled at same day and time as existing event.'

  #validate :duplicate_event?

  has_one :result

  after_initialize :init

  #has_and_belongs_to_many :teams, through: :events
  #has_and_belongs_to_many :opponents, through: :events

  def datetime
    dt = DateTime.parse(sprintf("%s %s", eventdate, eventtime))
    dt.strftime("%b %-d %Y @ %l:%M %p")
  end

  def datetimeshort
    dt = DateTime.parse(sprintf("%s %s", eventdate, eventtime))
    dt.strftime("%-m/%-d/%Y")
  end

  def datetimelong
    dt = DateTime.parse(sprintf("%s %s", eventdate, eventtime))
    dt.strftime("%A, %B %-d %Y at %l:%M %p")
  end

  def formalname
    t, s = eventtitle
    if s.blank?
      "#{datetimeshort}: #{t}"
    else
      "#{datetimeshort}: #{t} #{s}"
    end
  end

  ##  Generic event, not connected to a team?
  ##  Multi-team event?  Lots of possible scenarios ...
  def eventtitle
#logger.info(self.to_yaml)
    venue = Venue.find_by(:id => venueid)
    team = teamid.blank? ? nil : Team.find_by(:id => teamid)
    opponent = opponentid.blank? ? nil : Opponent.find_by(:id => opponentid)
    title = subtitle = ""
    if teamid.blank?
      title = description.blank? ? "N/A" : description
    elsif opponentid.blank? && opponents.count != 1
      title = "#{team.formalname} #{description}"
    elsif !opponentid.blank?
      title = "#{team.formalname} vs #{opponent.name}"
      subtitle = description unless description.nil?
    elsif !description.blank?
      title = description unless description.nil?
    else
      title = "None"
    end
    return title.strip, subtitle.strip
  end

  ##  Does event have a result?
  def getresult
    Result.find_by(:event_id => id)
  end

  private
  def init
    ##  Default to Scheduled for status if none set
    if self.new_record? && self.status.nil?
      self.status = 'scheduled'
    end
    ##  Default to Home for location if none set
    if self.new_record? && self.eventlocation.nil?
      self.eventlocation = 'home'
    end
    ##  Default to HomeVenueId for venue if none set
    if self.new_record? && self.venueid.nil?
      self.venueid = Settings.School.HomeVenueId
    end
    ##  Force event to be at home if venueid is home venue id
    self.eventlocation = 'home' if self.venueid == Settings.School.HomeVenueId
  end

  def duplicate_event?
    errors.add(:teamid, "Event already scheduled for this team on this date and time.") if
      Event.where("teamid = ? and eventdate = ? and eventtime = ?", self.teamid, self.eventdate, self.eventtime).any? and new_record?
  end

end
