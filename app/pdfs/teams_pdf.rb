class TeamsPdf < Prawn::Document
  
  include TeamsHelper

  def initialize(teams, options={})
    #logger.info "Here!"
    super(options)
    @teams = teams

    ##  Create a bounding box within the default bounding box which is slightly smaller.
    self.bounding_box([self.bounds.left + INNER_BOUNDING_BOX_MARGIN_TOP,
      self.bounds.top - 50],
      :width => self.bounds.width - INNER_BOUNDING_BOX_WIDTH,
      :height => self.bounds.height - INNER_BOUNDING_BOX_HEIGHT) do

Rails.logger.info(self.bounds.to_yaml)

    2.times do
      start_new_page
      #text_content
      3.times do
        table_content
      end
    end

    end

    PDFHeader(self)
    PDFFooter(self)
    #header
    #footer

  end
 
  def header
    #This inserts an image in the pdf file and sets the size of the image
    #image "#{Rails.root}/app/assets/images/header.png", width: 530, height: 150
    page_count.times do |i|
      go_to_page(i+1)
      self.bounding_box [self.bounds.left, self.bounds.top - 25], :width  => self.bounds.width do
        self.stroke_horizontal_rule
        self.move_up(25)
        self.text DateTime.now.strftime("%A, %B %-d %Y at %l:%M %p"), :size => 10, :align => :left
        self.move_up(25)
        self.text "Page #{i+1}/#{page_count}", :size => 10, :align => :right
      end
    end
  end

  def footer
    page_count.times do |i|
      go_to_page(i+1)
      self.bounding_box [self.bounds.left, self.bounds.bottom + 30], :width  => self.bounds.width do
        self.stroke_horizontal_rule
        self.move_down(5)
        #self.text "#{Settings.Header.Title} - #{Settings.Header.SubTitle}\n" +
        #  DateTime.now.strftime("%A, %B %-d %Y at %l:%M %p"), :size => 10, :align => :left
        #self.move_up(12)
        #self.text "Page #{i+1}/#{page_count}", :size => 10, :align => :right
        colw = self.bounds.width

        table footer_rows(i) do
          self.header = false
          self.column_widths = [colw - 150, 150]
          self.cell_style = { :size => 10, :padding => 0, :borders => [] }
          column(0).style(:align => :left)
          column(1).style(:align => :right)
        end
      end
    end
  end

  def footer_rows(page)
    [["#{Settings.Header.Title} - #{Settings.Header.SubTitle}\n" + DateTime.now.strftime("%A, %B %-d %Y at %l:%M %p"), "Page #{page+1}/#{page_count}"]]
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
