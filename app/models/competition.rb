# == Schema Information
#
# Table name: competitions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Competition < ActiveRecord::Base
  attr_accessible :name

  has_many :seasons, dependent: :destroy

  validates(:name, {
      presence: true,
      length: {maximum: 50}
    }
  )
end
