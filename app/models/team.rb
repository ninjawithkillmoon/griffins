class Team < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :players
  belongs_to :division

  validates(:name, {
      presence: true,
      length: {maximum: 50}
    }
  )
end
