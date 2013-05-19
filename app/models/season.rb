# == Schema Information
#
# Table name: seasons
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  date_start     :date
#  cost           :integer
#  cost_student   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  competition_id :integer
#

class Season < ActiveRecord::Base
  attr_accessible :cost, :cost_dollars, :cost_student, :cost_student_dollars, :date_start, :name, :competition_id, :division_ids

  has_many :divisions
  has_many :invoices
  belongs_to :competition

  validates(:name, {
      presence: true,
      length: {maximum: 50}
    }
  )

  validates(:date_start, {
      presence: true
    }
  )

  validates(:cost, {
      presence: true
    }
  )

  validates(:cost_student, {
      presence: true
    }
  )

  monetize :cost,         as: :cost_dollars
  monetize :cost_student, as: :cost_student_dollars
end
