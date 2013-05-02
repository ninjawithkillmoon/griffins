# == Schema Information
#
# Table name: divisions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sex        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :integer
#

class Division < ActiveRecord::Base
  attr_accessible :name, :sex, :season_id

  has_many :teams
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
