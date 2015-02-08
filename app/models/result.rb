class Result < ActiveRecord::Base
  belongs_to :event, :dependent => :destroy
  validates :result, :presence => { :message => 'Result must be specified.' }

  ##  Generic event, not connected to a team?
  ##  Multi-team event?  Lots of possible scenarios ...
  def resulttext
#logger.info(self.to_yaml)

    rs = rl = ""
    if !result.nil? then
        rl = result.camelize
    end

    ##  Need to drop decimal if score is whole
    ##  number which will typically be the case
    ##  I am sure there is a simpler way to do this

    if !teamscore.blank?
      ts = teamscore.to_s
      if ts[ts.length-2..ts.length-1] == ".0"
        ts = ts[0..ts.length-3]
      end
    end
        
    if !opponentscore.blank?
      os = opponentscore.to_s
      if os[os.length-2..os.length-1] == ".0"
        os = os[0..os.length-3]
      end
    end
         
    case result
    when /^(win|loss|tie)$/
      #logger.info(result.camelize)
      if !teamscore.blank?  && !opponentscore.blank?
        rl = "#{result.camelize}: #{ts} - #{os}"
        rs = "#{result.camelize[0]}: #{ts}-#{os}"
      elsif !teamscore.blank?
        rl = "#{result.camelize}: #{ts}"
        rs = "#{result.camelize[0]}: #{ts}"
      else
        rl = "#{result.camelize}"
        rs = "#{result.camelize[0]}"
      end
    when 'place'
      #logger.info('PLACE')
      if !teamscore.blank?  && !place.blank?
        rl = "#{place.ordinalize} #{result.camelize} #{ts} Points"
        rs = "#{place.ordinalize} #{result.camelize[0..1]}"
      elsif !place.blank?
        rl = "#{place.ordinalize} #{result.camelize}"
        rs = "#{place.ordinalize} #{result.camelize[0..1]}"
      elsif !teamscore.blank?
        rl = "#{ts} Points"
        rs = "#{ts} Pt"
      else
        rl = rs = "N/A"
      end
    when 'other'
      #logger.info('OTHER')
      rl = "Other"
      rs = "O"
    when 'none'
      #logger.info('NONE')
      rl = "No Score"
      rs = "NS"
    else
      #logger.info('UNKNOWN')
      rl = rs = "N/A"
    end

    return rl.strip, rs.strip

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

end
