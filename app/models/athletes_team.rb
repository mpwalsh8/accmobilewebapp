class AthletesTeam < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :team

  require 'csv'

  ##  CSV import
  def self.import(file, team_id)
    columns = AthletesTeam.column_names
    athletes = { :skipped => 0, :imported => 0 }
    team_athletes = { :skipped => 0, :imported => 0 }
    CSV.foreach(file.path, headers: true) do |row|

      athlete_hash = row.to_hash.compact # exclude the nil fields
      team_hash = Hash[columns.map {|k| [k, nil]}]

      ##  Handle :active field which is a boolean
      ##  but may come in as a yes not field ...

      if athlete_hash.has_key?("active")
        athlete_hash["active"] = to_boolean(athlete_hash["active"])
      end

      ##  Handle :captain field which is a boolean
      ##  but may come in as a yes/no field ...

      if athlete_hash.has_key?("captain")
        athlete_hash["captain"] = to_boolean(athlete_hash["captain"])
      end

      ##  Need to move any hash elements for the team to the hash

      team_hash.each do |k, v|
        if athlete_hash.has_key?(k)
          team_hash[k] = athlete_hash[k]
          athlete_hash.delete(k)
        end
      end

      athlete = Athlete.where(athlete_hash)

      ##  If the athlete exists, skip it otherwise,
      ##  create a new athlete with the provided info
      if athlete.count == 0
        athlete = Athlete.create!(athlete_hash)
        athletes[:imported] += 1
      else
        athlete = athlete.first
        athletes[:skipped] += 1
      end

      ##  Check to see if athlete is already on team roster
      team_hash[:athlete_id] = athlete.id
      team_hash.compact!

      team_athlete = AthletesTeam.where(team_hash)

      ##  If the team athlete exists, skip it otherwise,
      ##  create a new team athlete with the provided info
      if team_athlete.count == 0
        team_athlete = AthletesTeam.create!(team_hash)
        team_athletes[:imported] += 1
      else
        team_athlete = team_athlete.first
        team_athletes[:skipped] += 1
      end

    end

    return { :athletes => athletes, :team_athletes => team_athletes }
  end

  ##  Map strings to boolean
  def self.to_boolean(s)
    !!(s =~ /^(true|t|yes|y|1)$/i)
  end

end
