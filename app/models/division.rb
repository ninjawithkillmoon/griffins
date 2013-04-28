class Division < ActiveRecord::Base
  attr_accessible :name, :sex

  has_many :teams, dependent: :destroy
  belongs_to :season

  validates(:name, {
      presence: true,
      length: {maximum: 50}
    }
  )

  validates(:sex, {
      presence: true,
      format: {with: VALID_SEX_REGEX_DIVISION}
    }
  )
end
