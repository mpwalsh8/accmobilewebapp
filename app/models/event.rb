class Event < ActiveRecord::Base
  serialize :opponents
  validates :status, :presence => { :message => 'Status must be specified.' }
  validates :venueid, :presence => { :message => 'Venue must be specified.' }
  validates :eventlocation, :presence => { :message => 'Location must be specified.' }
  validates :eventdate, :presence => { :message => 'Event Date is required.' }
  validates :eventtime, :presence => { :message => 'Event Time is required.' }
  validates_format_of :eventdate, :message => 'Date must be YYYY-MM-DD format.', :with => /(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])/
  validates_format_of :eventtime, :message => 'Time must be HH:MM format.', :with => /([01]?[0-9]|2[0-3]):[0-5][0-9]/
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


##    ##  Construct the event content based on presence of opponents
##    def EventOverviewLI(event)
##      venue = Venue.find_by(:id => event.venueid)
##      team = event.teamid.blank? ? nil : Team.find_by(:id => event.teamid)
##      opponent = event.opponentid.blank? ? nil : Opponent.find_by(:id => event.opponentid)
##      status = event.status.blank? || event.status == 'scheduled' ? "" :
##        sprintf("<span class=\"event-%s\">%s</span><br />", event.status, event.status.camelize)
##  
##      title, subtitle = EventTitle(event, team, opponent)
##      if team.nil?
##        span = sprintf("<span class=\"ui-li-count-fix ui-li-count\">%s</span>",
##          event.eventlocation.camelize[0])
##        li = sprintf("<li>%s%s</li>",
##          link_to(sprintf("<img src=\"%s\" alt=\"%s\"><h2>%s</h2><p>%s%s at %s</p>",
##          image_url("pictograms/svg/Information-Blk.svg"),
##          "Information", title, status, event.datetime,
##          venue.name).html_safe, event), span)
##      elsif event.opponentid.blank?
##        span = sprintf("<span class=\"ui-li-count-fix ui-li-count\">%s</span>",
##          event.eventlocation.camelize[0])
##        li = sprintf("<li>%s%s</li>",
##          link_to(sprintf("<img src=\"%s\" alt=\"%s\"><h2>%s</h2><p>%s%s at %s</p>",
##          image_url("pictograms/svg/#{team.sport.imageurl}.svg"),
##          team.sport.name, team.formalname, status, event.datetime,
##          venue.name).html_safe, event), span)
##      else
##        span = sprintf("<span class=\"ui-li-count-fix ui-li-count\">%s / %s</span>",
##          event.eventlocation.camelize[0], opponent.conferenceopponent ? "C" : "N")
##        li = sprintf("<li>%s%s</li>",
##          link_to(sprintf("<img src=\"%s\" alt=\"%s\"><h2>%s vs %s</h2><p>%s%s at %s</p>",
##          image_url("pictograms/svg/#{team.sport.imageurl}.svg"),
##          team.sport.name, team.formalname, opponent.name, status, event.datetime,
##          venue.name).html_safe, event), span)
##       end
##  
##       return li.html_safe
##    end

  private
  def init
    if self.new_record? && self.status.nil?
      self.status = 'scheduled'
    end
    if self.new_record? && self.eventlocation.nil?
      self.eventlocation = 'home'
    end
  end
end
