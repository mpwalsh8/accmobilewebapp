class Coach < ActiveRecord::Base
  # a coach can coach more than one team
  has_and_belongs_to_many :teams, through: :coaches
  #has_and_belongs_to_many :sports, through: :teams

  require 'csv'

  ##  CSV import
  def self.import(file)
    columns = Coach.column_names
    coaches = { :skipped => 0, :imported => 0 }
    CSV.foreach(file.path, headers: true) do |row|

      ##  Hash the data and discard nil fields
      coach_hash = row.to_hash.compact

      ##  Discard any columns which don't match the model
      coach_hash.each do |k, v|
        if !columns.include?(k)
          coach_hash.delete(k)
        end
      end

      ##  Handle :active field which is a boolean
      ##  but may come in as a yes not field ...

      if coach_hash.has_key?("active")
        coach_hash["active"] = to_boolean(coach_hash["active"])
      end

      coach = Coach.where(coach_hash)

      ##  If the coach exists, skip it otherwise,
      ##  create a new coach with the provided info
      if coach.count == 0
        Coach.create!(coach_hash)
        coaches[:imported] += 1
      else
        coaches[:skipped] += 1
      end
    end

    return coaches
  end

  ##  Map strings to boolean
  def self.to_boolean(s)
    !!(s =~ /^(true|t|yes|y|1)$/i)
  end

  def fullname
    firstname + " " + lastname
  end

  def lastcommafirst
    lastname + ", " + firstname
  end

  def displayname
    if nickname.blank? then
      dn = sprintf("Coach %s %s", firstname, lastname)
    else
      dn = sprintf("Coach %s (%s) %s", firstname, nickname, lastname)
    end
  end

  #  Is coach on staff?
  def is_on_staff?(team)
    self.teams.include?(team)
  end

  #  Get all teams coach is on staff of
  def is_on_staff
    self.teams
  end

  #  Get all teams coach is not on staff of
  def is_not_on_staff
    #Team.find(:all) - self.teams
    Team.all - self.teams
  end
end
