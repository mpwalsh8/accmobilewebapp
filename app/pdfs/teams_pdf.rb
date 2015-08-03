class TeamsPdf < Prawn::Document
  
  include TeamsHelper

  def initialize(teams, options={})
    super(options)
    #@teams = teams

    start_new_page
    CoverPage(self, Settings.School.Name + " Yearbook")

    ##  Pull the teams based on the season - discard the teams passed in
    seasons = { 'fall' => "fall icon", 'winter' => 'winter icon', 'spring' => 'spring icon' }
    seasons.each do |key, value|
      @teams = Team.where(:season => key).sort { |a,b| a.sportname <=> b.sportname }


      ##  Create a bounding box within the default bounding box which is slightly smaller.
      self.bounding_box([self.bounds.left + INNER_BOUNDING_BOX_MARGIN_LEFT,
        self.bounds.top - INNER_BOUNDING_BOX_MARGIN_TOP],
        :width => self.bounds.width - INNER_BOUNDING_BOX_WIDTH,
        :height => self.bounds.height - INNER_BOUNDING_BOX_HEIGHT) do

        @teams.map do |team|
          @coaches = CoachesTeam.select("*").joins(:coach).where(:team_id => team.id)
          @athletes = AthletesTeam.select("*").joins(:athlete).where(:team_id => team.id)
          @jerseycount = AthletesTeam.select("*").joins(:athlete).where(:team_id => team.id).where.not(jerseynumber: [nil, '']).count
Rails.logger.info("++++++++++>" + @jerseycount.to_s)
          start_new_page
          text "#{team.formalname} (#{team.season.camelize})", :size => 20
          move_down(SECTION_SPACING)
          TeamReport(team)
        end
      end
    end

    ## Generate the header and footer for each page
    PDFHeader(self, Settings.School.Name + " Yearbook")
    PDFFooter(self)

  end
 
  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50
 
    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 270, :height => 300) do
      text "Lorem ipsum", size: 15, style: :bold
      text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum semper placerat. Aenean mattis fringilla risus ut fermentum. Fusce posuere dictum venenatis. Aliquam id tincidunt ante, eu pretium eros. Sed eget risus a nisl aliquet scelerisque sit amet id nisi. Praesent porta molestie ipsum, ac commodo erat hendrerit nec. Nullam interdum ipsum a quam euismod, at consequat libero bibendum. Nam at nulla fermentum, congue lectus ut, pulvinar nisl. Curabitur consectetur quis libero id laoreet. Fusce dictum metus et orci pretium, vel imperdiet est viverra. Morbi vitae libero in tortor mattis commodo. Ut sodales libero erat, at gravida enim rhoncus ut."
    end
 
    bounding_box([300, y_position], :width => 270, :height => 300) do
      text "Duis vel", size: 15, style: :bold
      text "Duis vel tortor elementum, ultrices tortor vel, accumsan dui. Nullam in dolor rutrum, gravida turpis eu, vestibulum lectus. Pellentesque aliquet dignissim justo ut fringilla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut venenatis massa non eros venenatis aliquet. Suspendisse potenti. Mauris sed tincidunt mauris, et vulputate risus. Aliquam eget nibh at erat dignissim aliquam non et risus. Fusce mattis neque id diam pulvinar, fermentum luctus enim porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
    end
 
  end
 
  def table_content
    # This makes a call to team_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    table team_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [40, 180, 180]
    end
  end
 
  def team_rows
    [['#', 'Name', 'Sport']] +
      @teams.map do |team|
      [team.id, team.formalname, team.sport.name]
    end
  end
end
