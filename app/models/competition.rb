class Competition < ActiveRecord::Base
  attr_accessible :name

  has_many :seasons
end
