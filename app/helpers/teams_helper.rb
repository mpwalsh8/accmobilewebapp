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
    #text "Id:  ##{@team.id}"
    #text "#{@team.formalname}", :size => 20
    #move_down(SECTION_SPACING)
    Rails.logger.info("pictograms/svg/#{team.sport.imageurl}.svg")
    svg File.read("#{Rails.root}/app/assets/images/pictograms/svg/#{team.sport.imageurl}.svg"), :width => 80, :height => 80
    move_down(SECTION_SPACING)
    TeamEvents(team)
    move_down(SECTION_SPACING)
    text "TBD"
    move_down(SECTION_SPACING)
    text "Coaching Staff", :size => 18
    move_down(SECTION_SPACING)
    text "TBD"
    move_down(SECTION_SPACING)
    text "Roster by Name", :size => 18
    move_down(SECTION_SPACING)
    text "TBD"
    move_down(SECTION_SPACING)
    text "Roster by Jersey Number", :size => 18
    move_down(SECTION_SPACING)
    text "TBD"
    move_down(SECTION_SPACING)
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
      #events.each do |event|
        #text event.to_yaml
      #end 
      TeamEventsTable(events)
    else
      text "No events scheduled."
    end

  end

  def TeamEventsTable(events)
    table TeamEventsRows(events) do
      row(0).font_style = :bold
       self.header = true
       self.row_colors = ['DDDDDD', 'FFFFFF']
       self.column_widths = [80, 250, 80, 80]
    end

  end

  def TeamEventsRows(events)
    rows = [['Date', 'Opponent', 'Location', 'Result']]
      events.map do |event|
      venue = Venue.find_by(:id => event.venueid)
      team = event.teamid.blank? ? nil : Team.find_by(:id => event.teamid)
      opponent = event.opponentid.blank? ? nil : Opponent.find_by(:id => event.opponentid)
      status = event.status.blank? || event.status == 'scheduled' ? "" :
        sprintf("%s", event.status, event.status.camelize)
      result = Result.find_by(:event_id => event.id)
      rs = result.nil? ? "" : sprintf("%s", result.resulttext[1])
      title, subtitle = event.formalname

        #row = [event.eventdate]
        #opponent = event.opponentid.blank? ? nil : Opponent.find_by(:id => event.opponentid)
        #rows += [[event.eventdate, event.eventtitle, event.eventlocation, "TBD"]]
#Rails.logger.info("1+++++++++++++++++++++++++++++++++++")
#Rails.logger.info(event.eventtitle.to_yaml)
#Rails.logger.info("2+++++++++++++++++++++++++++++++++++")
#Rails.logger.info(event.formalname.to_yaml)
#Rails.logger.info("3+++++++++++++++++++++++++++++++++++")
        rows += [[event.datetimeshort, event.eventtitle[0], event.eventlocation.camelize, rs]]
#Rails.logger.info("1+++++++++++++++++++++++++++++++++++")
#Rails.logger.info(opponent.to_yaml)
#Rails.logger.info(rs)
    end
    return rows
  end


end
