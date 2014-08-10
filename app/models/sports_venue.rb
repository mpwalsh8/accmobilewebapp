class SportsVenue < ActiveRecord::Base
  belongs_to :sport
  belongs_to :venue
end
