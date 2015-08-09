class TeamsPdf < Prawn::Document
  
  include TeamsHelper

  def initialize(teams, options={})
    super(options)
    #@teams = teams

    start_new_page
    #CoverPage(self, Settings.School.Name + " Athletics:  Year in Review " + Settings.School.SchoolYear)
    CoverPage(self, "Year in Review")

    ##  Create a bounding box within the default bounding box which is slightly smaller.
    self.bounding_box([self.bounds.left + INNER_BOUNDING_BOX_MARGIN_LEFT,
      self.bounds.top - INNER_BOUNDING_BOX_MARGIN_TOP],
      :width => self.bounds.width - INNER_BOUNDING_BOX_WIDTH,
      :height => self.bounds.height - INNER_BOUNDING_BOX_HEIGHT) do

      ##  Pull the teams based on the season - discard the teams passed in
      seasons = { 'fall' => "fall icon", 'winter' => 'winter icon', 'spring' => 'spring icon' }
      seasons.each do |key, value|
        @teams = Team.where(:season => key).sort { |a,b| a.sportname <=> b.sportname }

        @teams.map do |team|
          @coaches = CoachesTeam.select("*").joins(:coach).where(:team_id => team.id)
          @athletes = AthletesTeam.select("*").joins(:athlete).where(:team_id => team.id)
          @jerseycount = AthletesTeam.select("*").joins(:athlete).where(:team_id => team.id).where.not(jerseynumber: [nil, '']).count
          start_new_page
          text "#{team.formalname} (#{team.season.camelize})", :size => 20
          move_down(SECTION_SPACING)
          TeamReport(team)
        end
      end
      Sponsors(self)
    end

    ## Generate the header and footer for each page
    PDFHeader(self, Settings.School.Name + " Athletics:  Year in Review " + Settings.School.SchoolYear)
    PDFFooter(self)

  end
end
