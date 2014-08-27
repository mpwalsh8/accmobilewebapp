class Event < ActiveRecord::Base
  has_and_belongs_to_many :teams, through: :events
  has_and_belongs_to_many :opponents, through: :events
end
