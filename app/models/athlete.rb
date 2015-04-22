class Athlete < ActiveRecord::Base
  include Utility
  # an athlete can be on more than one team
  has_and_belongs_to_many :teams, through: :athletes

  require 'csv'

  ##  CSV import
  def self.import(file)
    columns = Athlete.column_names
    athletes = { :skipped => 0, :imported => 0 }
    CSV.foreach(file.path, headers: true) do |row|

      ##  Hash the data and discard nil fields
      athlete_hash = row.to_hash.compact

      ##  Discard any columns which don't match the model
      athlete_hash.each do |k, v|
        if !columns.include?(k)
          athlete_hash.delete(k)
        end
      end

      ##  Handle :active field which is a boolean
      ##  but may come in as a yes not field ...

      if athlete_hash.has_key?("active")
        athlete_hash["active"] = to_boolean(athlete_hash["active"])
      else
        athlete_hash["active"] = true
      end

      ##  First try a full match
      athlete = Athlete.where(athlete_hash)

      ##  If no match, before creating a new athlete,
      ##  try matching just the first and last name.
      if athlete.count == 0
        alt_athlete_hash = Hash.new
        alt_athlete_hash["firstname"] = row["firstname"]
        alt_athlete_hash["lastname"] = row["lastname"]
        athlete = Athlete.where(alt_athlete_hash)
        if athlete.count == 0
          match = :none
        else
          match = :partial
        end
      else
        match = :full
      end
      
      ##  If the athlete exists, skip it otherwise,
      ##  create a new athlete with the provided info
      if match == :none
        Athlete.create!(athlete_hash)
        athletes[:imported] += 1
      elsif match == :partial
        Athlete.update(athlete.first.id, athlete_hash)
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

##    ##  Athlete full name
##    def fullname
##      firstname + " " + lastname
##    end
##  
##    ##  Athlete full name, last, first
##    def lastcommafirst
##      lastname + ", " + firstname
##    end
##  
##    ##  Athlete display name including nickname if present
##    def displayname
##      if nickname.blank? then
##        dn = sprintf("%s %s", firstname, lastname)
##      else
##        dn = sprintf("%s (%s) %s", firstname, nickname, lastname)
##      end
##    end
##  
##    ##  Convert height in inches to feet and inches
##    def height2text
##      if height.blank? then
##        pec = "n/a"
##      else
##        divmod_output = height.divmod(12)
##        pec = sprintf("%d'%d\"", divmod_output[0], divmod_output[1])
##      end
##    end
##  
##    ##  Convert grad year to class
##    def gradyear2class
##      if gradyear.is_a? Integer then
##        cgy = Date.today.month <= 6 ? Date.today.year : Date.today.next_year.year
##        gradclass = { cgy => 'Senior', cgy+1 => 'Junior', cgy+2 => 'Sophomore', cgy+3 => 'Freshman' }[gradyear]
##      else
##        gradclass = 'n/a'
##      end
##    end

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

