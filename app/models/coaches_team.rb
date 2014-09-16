class CoachesTeam < ActiveRecord::Base
  include Utility
  belongs_to :team
  belongs_to :coach
end
