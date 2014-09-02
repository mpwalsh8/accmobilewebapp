class Athlete < ActiveRecord::Base
  # an athlete can be on more than one team
  has_and_belongs_to_many :teams, through: :athletes

  require 'csv'

  ##  CSV import
  def self.import(file)
    athletes = { :skipped => 0, :imported => 0 }
    CSV.foreach(file.path, headers: true) do |row|

      athlete_hash = row.to_hash.compact # exclude the nil fields

      ##  Handle :active field which is a boolean
      ##  but may come in as a yes not field ...

      if athlete_hash.has_key?("active")
        athlete_hash["active"] = to_boolean(athlete_hash["active"])
      end

      athlete = Athlete.where(athlete_hash)
      
      ##  If the athlete exists, skip it otherwise,
      ##  create a new athlete with the provided info
      if athlete.count == 0
        Athlete.create!(athlete_hash)
        athletes[:imported] += 1
      else
        athletes[:skipped] += 1
      end
    end

    return athletes
  end

  ##  Map strings to boolean
  def self.to_boolean(s)
    !!(s =~ /^(true|t|yes|y|1)$/i)
  end

  ##  Athlete full name
  def fullname
    firstname + " " + lastname
  end

  ##  Athlete full name, last, first
  def lastcommafirst
    lastname + ", " + firstname
  end

  ##  Athlete display name including nickname if present
  def displayname
    if nickname.blank? then
      dn = sprintf("%s %s", firstname, lastname)
    else
      dn = sprintf("%s (%s) %s", firstname, nickname, lastname)
    end
  end

  ##  Convert height in inches to feet and inches
  def height2text
    if height.blank? then
      pec = "n/a"
    else
      divmod_output = height.divmod(12)
      pec = sprintf("%d'%d\"", divmod_output[0], divmod_output[1])
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

