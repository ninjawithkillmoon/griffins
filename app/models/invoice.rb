# == Schema Information
#
# Table name: invoices
#
#  id         :integer          not null, primary key
#  notes      :text
#  amount     :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :integer
#  season_id  :integer
#

class Invoice < ActiveRecord::Base
  attr_accessible :amount, :notes, :payment_ids, :season_id, :player_id

  has_many :payments, dependent: :restrict
  belongs_to :season
  belongs_to :player

  validates(:player, {
      presence: true,
    }
  )

  validates(:amount, {
      presence: true,
    }
  )

  def outstanding
    @outstanding ||= calc_outstanding
  end

  def calc_outstanding
    remains = self.amount

    self.payments.each do |payment|
      remains -= payment.amount
    end

    return remains
  end
end
