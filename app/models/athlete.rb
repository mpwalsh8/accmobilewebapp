class Athlete < ActiveRecord::Base
  # an athlete can be on more than one team
  has_and_belongs_to_many :teams, through: :athletes

  require 'csv'

  ##  CSV import
  def self.import(file)
    logger.info(sprintf("self.import - %s::%s", __FILE__, __LINE__))
    CSV.foreach(file.path, headers: true) do |row|

      athlete_hash = row.to_hash # exclude the ? field
      athlete = Athlete.where(id: athlete_hash["id"])

      ##  If the athlete exists, update it with any new data
      if athlete.count == 1
        athlete.first.update_attributes
      else
        Athlete.create!(athlete_hash)
      end # end if !athlete.nil?
    end # end CSV.foreach
  end # end self.import(file)

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

