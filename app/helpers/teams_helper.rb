module TeamsHelper

  INNER_BOUNDING_BOX_WIDTH = 50
  INNER_BOUNDING_BOX_HEIGHT = 100
  INNER_BOUNDING_BOX_MARGIN_TOP = 50
  INNER_BOUNDING_BOX_MARGIN_LEFT = 25
  SECTION_SPACING = 8

  def CoverPage(pdf, title)
    10.times do
      move_down(SECTION_SPACING)
    end
    bounding_box([50, cursor], :position => :center, :width => 430) do
      svg File.read("#{Rails.root}/app/assets/images/BigALogoYellow.svg"), :position => :center, :fit => [600, 600]
    3.times do
      move_down(SECTION_SPACING)
    end
    text Settings.School.SchoolYear, :align => :center, :size => 32
    text Settings.School.Name, :align => :center, :size => 20
    text Settings.School.Address, :align => :center
    text "#{Settings.School.City}, #{Settings.School.State}  #{Settings.School.ZipCode}", :align => :center
    end
  end

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
    rows = []
    events = Event.where(:teamid => team.id).order(:eventdate, :eventtime)
    text "Schedule / Results (#{events.count})", :size => 18
    if events.count > 0
      record = team.record(false)
      if !record.blank?
        #text "Overall:  #{record}"
        rows.push(["Overall:",  record])
      end
      record = team.record(true)
      if !record.blank?
        #text "Conference:  #{record}"
        rows.push(["Conference:",  record])
      end
      if rows.count > 0
        table(rows, :cell_style => { :borders => [], :size => 14 }, :column_widths => [100, 50])
        move_down(SECTION_SPACING)
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
    rows = []
    text "Coaching Staff (#{team.coaches.count})", :size => 18
    if team.coaches.count > 0
      @coaches = @coaches.sort_by { |c| [ c.lastname, c.firstname ] }
      @coaches.each do |c|
        hc = CoachesTeam.find_by(:coach_id => c.id, :team_id => team.id)
        #text c.lastcommafirst + (hc.headcoach.blank? ? "" : " (Head Coach)")
        if hc.headcoach.blank?
          #rows.push(["\u2022", c.fullname, "Assistant Coach:"])
          rows.push(["Assistant Coach:", c.fullname])
        else
          #rows.unshift(["\u2022", c.fullname, "Head Coach:"])
          rows.unshift(["Head Coach:", c.fullname])
        end
      end
      table(rows, :cell_style => { :borders => [], :size => 14 }, :column_widths => [125, 250])
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
      if row(0).count == 3
        self.column_widths = [210, 200, 80]
      else
        self.column_widths = [250, 240]
      end
    end
  end

  ##  Build an array of rows for the team's athletes and results
  def TeamAthletesRows(team, sort = :name)
    if @jerseycount > 0
      rows = [['Name', 'Notes', 'Number']]
    else
      rows = [['Name', 'Notes']]
    end

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
      if @jerseycount > 0
        rows += [[a.lastcommafirst, notes, a.jerseynumber.blank? ? "" : a.jerseynumber]]
      else
        rows += [[a.lastcommafirst, notes]]
      end
    end
    return rows
  end

  ##  Sponsor page(s)
  def Sponsors(pdf, title)
    start_new_page
    SplashTable()
    start_new_page
    BannerTable()
  end

  def SplashTable
    table SplashRows() do
      self.cell_style = { :padding => 5, :borders => [] }
      columns(0).width = 240
      columns(1).width = 240
      self.header = true
    end
  end

  def SplashRows
    rows = [[{:content => Settings.School.SchoolYear + " Black Patrons", :colspan => 2, :size => 24}]]
    s = ACCMobileWebApp::Application::SPLASHADS
    (0...s.length).step(2) do |splash|
      lpath = Pathname.new("#{Rails.root}/app/assets/images/#{s[splash][:img]}")
      lpath = File.join(File.dirname(lpath), File.basename(lpath, File.extname(lpath))) + ".jpg"
      if !s[splash+1].nil?
        rpath = Pathname.new("#{Rails.root}/app/assets/images/#{s[splash+1][:img]}")
        rpath = File.join(File.dirname(rpath), File.basename(rpath, File.extname(rpath))) + ".jpg"
     
        row = [ {:image => lpath, :fit => [400, 240], :height => 280, :position => :center, :vposition => :center},
          {:image => rpath, :fit => [400, 240], :position => :center, :vposition => :center}, ""]
      else
        row = [ {:image => lpath, :fit => [400, 240], :height => 280, :position => :center, :vposition => :center}, ""]
      end
      rows.push row
    end
    return rows
  end

  def BannerTable
    table BannerRows() do
      self.cell_style = { :padding => 5, :borders => [] }
      columns(0).width = 240
      columns(1).width = 240
      self.header = true
    end
  end

  def BannerRows
    rows = [[{:content => Settings.School.SchoolYear + " Gold Patrons", :colspan => 2, :size => 24}]]
    b = ACCMobileWebApp::Application::BANNERADS
    (0...b.length).step(2) do |banner|
      lpath = Pathname.new("#{Rails.root}/app/assets/images/#{b[banner][:img]}")
      lpath = File.join(File.dirname(lpath), File.basename(lpath, File.extname(lpath))) + ".jpg"
      if !b[banner+1].nil?
        rpath = Pathname.new("#{Rails.root}/app/assets/images/#{b[banner+1][:img]}")
        rpath = File.join(File.dirname(rpath), File.basename(rpath, File.extname(rpath))) + ".jpg"
     
        row = [ {:image => lpath, :fit => [230, 80], :height => 75, :position => :center, :vposition => :center},
          {:image => rpath, :fit => [230, 80], :position => :center, :vposition => :center}, ""]
      else
        row = [ {:image => lpath, :fit => [230, 80], :height => 75, :position => :center, :vposition => :center}, ""]
      end
      rows.push row
    end
    return rows
  end
end
