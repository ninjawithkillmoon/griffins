# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  amount     :decimal(, )
#  method     :integer
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  invoice_id :integer
#

class Payment < ActiveRecord::Base
  attr_accessible :amount, :method, :notes, :invoice_id

  belongs_to :invoice

  validates(:invoice, {
      presence: true,
    }
  )

  validates(:amount, {
      presence: true,
    }
  )

  validates(:method, {
      presence: true,
      format: {with: VALID_METHOD_REGEX},
    }
  )
end
