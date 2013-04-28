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
