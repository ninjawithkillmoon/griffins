class Player < ActiveRecord::Base
  attr_accessible :date_of_birth, :email, :sex, :name_family, :name_given, :student_number

  has_and_belongs_to_many :teams

  before_save{ |player| player.email = email.downcase }

  validates(:name_family, {
      presence: true,
      length: {maximum: 50}
    }
  )

  validates(:name_given, {
      presence: true,
      length: {maximum: 50}
    }
  )

  validates(:email, {
      format: {with: VALID_EMAIL_REGEX},
      uniqueness: {case_sensitive: false}
    }
  )

  validates(:sex, {
      presence: true,
      format: {with: VALID_SEX_REGEX_PLAYER}
    }
  )
end
