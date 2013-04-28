class Competition < ActiveRecord::Base
  attr_accessible :name

  has_many :seasons, dependent: :destroy

  validates(:name, {
      presence: true,
      length: {maximum: 50}
    }
  )
end
