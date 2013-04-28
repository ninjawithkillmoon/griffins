class Division < ActiveRecord::Base
  attr_accessible :name, :sex

  has_many :teams
  belongs_to :season
end
