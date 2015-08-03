module Utility
  ##  Full name
  def fullname
    firstname + " " + lastname
  end

  ##  full name, last, first
  def lastcommafirst
    lastname + ", " + firstname
  end

  ##  Display name including nickname if present
  def displayname
    if nickname.blank? then
      dn = sprintf("%s %s", firstname, lastname)
    else
      dn = sprintf("%s (%s) %s", firstname, nickname, lastname)
    end
  end

  ##  Convert height in inches to feet and inches
  def height2text
    if height.blank? then
      pec = "n/a"
    else
      divmod_output = height.divmod(12)
      pec = sprintf("%d'%d\"", divmod_output[0], divmod_output[1])
    end
  end

  ##  Convert grad year to class
  def gradyear2class
    if gradyear.is_a? Integer then
      cgy = Date.today.month <= 8 ? Date.today.year : Date.today.next_year.year
      gradclass = { cgy => 'Senior', cgy+1 => 'Junior', cgy+2 => 'Sophomore', cgy+3 => 'Freshman' }[gradyear]
    else
      gradclass = 'n/a'
    end
  end

  def QQQ
    sprintf("%s", __FILE__)
  end

  module Event
    def test
      sprintf("%s", __FILE__)
    end
  end
end
