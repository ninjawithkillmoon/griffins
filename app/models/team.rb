# == Schema Information
#
# Table name: teams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  division_id :integer
#

class Team < ActiveRecord::Base
  attr_accessible :name, :division_id

  has_and_belongs_to_many :players
  belongs_to :division

  validates(:name, {
      presence: true,
      length: {maximum: 50}
    }
  )
end
