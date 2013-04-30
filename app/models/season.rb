# == Schema Information
#
# Table name: seasons
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  date_start     :date
#  cost           :decimal(, )
#  cost_student   :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  competition_id :integer
#

class Season < ActiveRecord::Base
  attr_accessible :cost, :cost_student, :date_start, :name

  has_many :divisions, dependent: :destroy
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
end
