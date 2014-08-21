class Team < ActiveRecord::Base
  belongs_to :sport
  has_and_belongs_to_many :coaches
  has_and_belongs_to_many :athletes

  #  The "formal name" is derived from the gender,
  #  the sport name, and varsity or jv designation. 

  def formalname
    if (gender != 'co-ed')
      sprintf("%s's %s %s", gender.camelize,
        varsity? ? "Varsity" : "JV", sport.name)
    else
      sprintf("%s %s",
        varsity? ? "Varsity" : "JV", sport.name)
    end
  end
end
