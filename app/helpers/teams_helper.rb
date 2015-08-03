module TeamsHelper

  INNER_BOUNDING_BOX_WIDTH = 50
  INNER_BOUNDING_BOX_HEIGHT = 100
  INNER_BOUNDING_BOX_MARGIN_TOP = 50
  INNER_BOUNDING_BOX_MARGIN_LEFT = 25
  SECTION_SPACING = 8

  ##  Construct the header of a PDF document
  def PDFHeader(pdf, title)
    #This inserts an image in the pdf file and sets the size of the image
    #image "#{Rails.root}/app/assets/images/header.png", width: 530, height: 150

    ##  Loop through the pages
    page_count.times do |i|
      go_to_page(i+1)
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 25], :width  => pdf.bounds.width do
        pdf.stroke_horizontal_rule
        pdf.move_up(25)
        pdf.text title, :size => 20, :align => :left
      end
    end
  end

  def PDFFooter(pdf)
    page_count.times do |i|
      go_to_page(i+1)
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 30], :width  => pdf.bounds.width do
        pdf.stroke_horizontal_rule
        pdf.move_down(5)
        colw = pdf.bounds.width

        table PDFFooterRows(i, pdf.page_count) do
          self.header = false
          self.column_widths = [colw - 150, 150]
          self.cell_style = { :size => 10, :padding => 0, :borders => [] }
          column(0).style(:align => :left)
          column(1).style(:align => :right)
        end
      end
    end
  end

  def PDFFooterRows(page, numpages)
    [["#{Settings.Header.Title} - #{Settings.Header.SubTitle}\n" + DateTime.now.strftime("%A, %B %-d %Y at %l:%M %p"), "Page #{page+1}/#{numpages}"]]
  end

  def TeamReport(team)
    svg File.read("#{Rails.root}/app/assets/images/pictograms/svg/#{team.sport.imageurl}.svg"), :width => 80, :height => 80
    move_down(SECTION_SPACING)

    ## Team Picture?
    if !team.teampicurl.blank?
      move_down(SECTION_SPACING)
      bounding_box([50, cursor], :position => :center, :width => 400) do
        image open(team.teampicurl), :position => :center, :fit => [400,400]
        stroke_bounds
      end
      3.times do
        move_down(SECTION_SPACING)
      end
    end

    TeamEvents(team)
    3.times do
      move_down(SECTION_SPACING)
    end

    TeamCoaches(team)
    3.times do
      move_down(SECTION_SPACING)
    end

    ##  Generate a roster sortd by name
    TeamAthletes(team, :name)
    3.times do
      move_down(SECTION_SPACING)
    end

    ##  Only generate a roster sorted by jersey number
    ##  when the team actually assigns jersey numbers.
    if @jerseycount > 0
      TeamAthletes(team, :jerseynumber)
      3.times do
        move_down(SECTION_SPACING)
      end
    end

  end

  def TeamEvents(team)
    events = Event.where(:teamid => team.id).order(:eventdate, :eventtime)
    text "Schedule / Results (#{events.count})", :size => 18
    if events.count > 0
      record = team.record(false)
      if !record.blank?
        text "Overall:  #{record}"
      end
      record = team.record(true)
      if !record.blank?
        text "Confernece:  #{record}"
      end
      TeamEventsTable(events, team.formalname)
    else
      text "No events scheduled."
    end
  end

  def TeamEventsTable(events, fn)
    table TeamEventsRows(events, fn) do
      row(0).font_style = :bold
       self.header = true
       self.row_colors = ['DDDDDD', 'FFFFFF']
       self.column_widths = [80, 250, 80, 80]
    end

  end

  ##  Build an array of rows for the team's events and results
  def TeamEventsRows(events, fn)
    rows = [['Date', 'Opponent', 'Location', 'Result']]
    events.map do |event|
      opponent = event.opponentid.blank? ? nil : Opponent.find_by(:id => event.opponentid)
      result = Result.find_by(:event_id => event.id)
      rs = result.nil? ? "" : sprintf("%s", result.resulttext[1])

      rows += [[event.datetimeshort,
        event.eventtitle[0].remove!(fn).strip.remove!("vs ").strip,
        event.eventlocation.camelize, rs]]
    end
    return rows
  end

  ##  Output the coaches for the specified team
  def TeamCoaches(team)
    text "Coaching Staff (#{team.coaches.count})", :size => 18
    if team.coaches.count > 0
      @coaches = @coaches.sort_by { |c| [ c.lastname, c.firstname ] }
      @coaches.each do |c|
        hc = CoachesTeam.find_by(:coach_id => c.id, :team_id => team.id)
        text c.lastcommafirst + (hc.headcoach.blank? ? "" : " (Head Coach)")
      end
    else
      text "No coaches currently on staff."
    end
  end

  def TeamAthletes(team, sort = :name)
    if sort == :jerseynumber
      text "Roster by Jersey Number (#{team.athletes.count})", :size => 18
    else
      text "Roster by Name (#{team.athletes.count})", :size => 18
    end

    if team.athletes.count > 0
      TeamAthletesTable(team, sort)
    else
      text "No athletes currently on roster."
    end
  end

  def TeamAthletesTable(team, sort)
    table TeamAthletesRows(team, sort) do
      row(0).font_style = :bold
       self.header = true
       self.row_colors = ['DDDDDD', 'FFFFFF']
       self.column_widths = [210, 200, 80]
    end

  end

  ##  Build an array of rows for the team's athletes and results
  def TeamAthletesRows(team, sort = :name)
    rows = [['Name', 'Notes', 'Number']]
    if sort == :jerseynumber
      @athletes = @athletes.sort_by { |a| [ a.jerseynumber.to_i, a.lastname, a.firstname ] }
    else
      @athletes = @athletes.sort_by { |a| [ a.lastname, a.firstname ] }
    end
    @athletes.each do |a|
      notes = a.gradyear2class
      if !a.position.blank?
        notes = sprintf("%s%s%s", notes, notes.blank? ? "" : " / ", a.position)
      end
      if a.captain
        notes = sprintf("%s%s", notes, notes.blank? ? "Captain" : " / Captain")
      end
      rows += [[a.lastcommafirst, notes, a.jerseynumber.blank? ? "" : a.jerseynumber]]
    end
    return rows
  end

end
