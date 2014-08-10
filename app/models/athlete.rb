class Athlete < ActiveRecord::Base
  # an athlete can be on more than one team
  has_and_belongs_to_many :teams, through: :athletes

  def fullname
    firstname + " " + lastname
  end

  def lastcommafirst
    lastname + ", " + firstname
  end

  def displayname
    if nickname.blank? then
      dn = sprintf("%s %s", firstname, lastname)
    else
      dn = sprintf("%s (%s) %s", firstname, nickname, lastname)
    end
  end

  #  Is athlete on roster?
  def is_on_roster?(team)
    self.teams.include?(team)
  end

  #  Get all teams coach is on roster of
  def is_on_roster
    self.teams
  end

  #  Get all teams coach is not on roster of
  def is_not_on_roster
    #Team.find(:all) - self.teams
    Team.all - self.teams
  end
end

