module TeamsHelper

  INNER_BOUNDING_BOX_WIDTH = 100
  INNER_BOUNDING_BOX_HEIGHT = 100
  INNER_BOUNDING_BOX_MARGIN_TOP = 50
  INNER_BOUNDING_BOX_MARGIN_LEFT = 50

  ##  Construct the header of a PDF document
  def PDFHeader(pdf)
    #This inserts an image in the pdf file and sets the size of the image
    #image "#{Rails.root}/app/assets/images/header.png", width: 530, height: 150

    ##  Loop through the pages
    page_count.times do |i|
      go_to_page(i+1)
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 25], :width  => pdf.bounds.width do
        pdf.stroke_horizontal_rule
        pdf.move_up(25)
        pdf.text DateTime.now.strftime("%A, %B %-d %Y at %l:%M %p"), :size => 10, :align => :left
        pdf.move_up(25)
        pdf.text "Page #{i+1}/#{page_count}", :size => 10, :align => :right
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

end
