class Invoice < ActiveRecord::Base
  attr_accessible :amount, :notes, :payment_ids, :season_id, :player_id

  has_many :payments
  belongs_to :season
  belongs_to :player

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
