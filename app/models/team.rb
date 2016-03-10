class Team < ActiveRecord::Base
  belongs_to :sport
  has_and_belongs_to_many :coaches
  has_and_belongs_to_many :athletes
  #validates_uniqueness_of :formalname

  #  The "formal name" is derived from the gender,
  #  the sport name, and varsity or jv designation. 

  def formalname
    if gender != 'co-ed' && showgender
      sprintf("%s's %s%s %s", gender.camelize,
        varsity? ? "" : "JV", suffix.blank? ? "" : "-#{suffix.upcase}", sport.name).gsub(/\s+/, ' ')
    else
      sprintf("%s%s %s",
        varsity? ? "" : "JV", suffix.blank? ? "" : "-#{suffix.upcase}", sport.name).gsub(/\s+/, ' ')
    end
  end

  #  The "sport name" is derived from the gender,
  #  the sport name, and varsity or jv designation. 

  def sportname
    logger.info('============')
    logger.info(sport.to_yaml)
    logger.info('============')
    if gender != 'co-ed' && showgender
      sprintf("%s %s%s - %s", sport.name,
        varsity? ? "" : "JV", suffix.blank? ? "" : "-#{suffix.upcase}",  gender.camelize)
    else
      sprintf("%s %s%s", sport.name,
        varsity? ? "" : "JV", suffix.blank? ? "" : "-#{suffix.upcase}")
    end
  end

  def record(conference = false)
    if (conference)
      opponents = Opponent.select("id").where(:conferenceopponent => true)
      opponents = opponents.map{|opponent| opponent.id}
    #logger.info(opponents.to_yaml)
      results = Result.select("result").joins(:event).where("result IN ('win', 'loss', 'tie') AND results.event_id = events.id AND events.teamid = ? AND events.opponentid IN (?)", id, opponents)
    else
      results = Result.select("result").joins(:event).where("result IN ('win', 'loss', 'tie') AND results.event_id = events.id AND events.opponentid IS NOT NULL AND events.teamid = ?", id)
    end
    #logger.info('============')
    #logger.info(results.to_yaml)
    results = results.map{|result| result.result}
    if results.count > 0 && results.count('tie') > 0
      #results = sprintf("W: %d L: %d T: %d", results.count('win'),
      results = sprintf("%d-%d-%d", results.count('win'),
        results.count('loss'), results.count('tie'))
    else
      #results = results.count > 0 ? sprintf("W: %d L: %d", results.count('win'), results.count('loss')) : ""
      results = results.count > 0 ? sprintf("%d-%d", results.count('win'), results.count('loss')) : ""
    end
  end
end
