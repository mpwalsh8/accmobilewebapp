class Event < ActiveRecord::Base
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
