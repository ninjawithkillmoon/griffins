class Season < ActiveRecord::Base
  attr_accessible :cost, :cost_student, :date_start, :name

  has_many :divisions
  belongs_to :competition
end
