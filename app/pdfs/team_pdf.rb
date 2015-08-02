class TeamPdf< Prawn::Document

  include TeamsHelper

  def initialize(team, options={})
    super(options)
    @team = team

    ##  Create a bounding box within the default bounding box which is slightly smaller.
    self.bounding_box([self.bounds.left + INNER_BOUNDING_BOX_MARGIN_TOP,
      self.bounds.top - 50],
      :width => self.bounds.width - INNER_BOUNDING_BOX_WIDTH,
      :height => self.bounds.height - INNER_BOUNDING_BOX_HEIGHT) do
      text "Id\##{@team.id}"
      text "Name\##{@team.formalname}"
    end

    PDFHeader(self)
    PDFFooter(self)
  end

end
