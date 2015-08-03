class TeamPdf< Prawn::Document

  include TeamsHelper

  def initialize(team, options={})
    super(options)
    @team = team

    ##  Create a bounding box within the default bounding box which is slightly smaller.
    self.bounding_box([ self.bounds.left + INNER_BOUNDING_BOX_MARGIN_LEFT,
      self.bounds.top - INNER_BOUNDING_BOX_MARGIN_TOP ],
      :width => self.bounds.width - INNER_BOUNDING_BOX_WIDTH,
      :height => self.bounds.height - INNER_BOUNDING_BOX_HEIGHT) do
      TeamReport(team)
    end

    PDFHeader(self, Settings.School.Name + " " + @team.formalname)
    PDFFooter(self)
  end

end
