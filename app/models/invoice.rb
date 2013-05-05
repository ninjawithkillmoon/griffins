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
  attr_accessible :amount, :amount_dollars, :notes, :outstanding, :outstanding_dollars, :payment_ids, :season_id, :player_id

  has_many :payments, dependent: :restrict
  belongs_to :season
  belongs_to :player

  before_validation do |invoice|
    invoice.recalculate_outstanding
  end

  validates(:player, {
      presence: true,
    }
  )

  validates(:amount, {
      presence: true,
    }
  )

  monetize :amount     , as: :amount_dollars
  monetize :outstanding, as: :outstanding_dollars

  # Goes through the payments made to this invoice and recalculates the outstanding amount. 
  #
  # Sets self.outstanding to the oustanding amount. Does not perform any save of this object.
  #
  def recalculate_outstanding
    due = self.amount
    self.payments.each do |payment|
      due -= payment.amount
    end

    self.outstanding = due
  end

  def pay(p_amount)
    self.outstanding -= p_amount
    self.save!
  end

  def unpay(p_amount)
    self.outstanding += p_amount
    self.save!
  end

  def self.for_season(p_season_id)
    unless p_season_id.blank?
      where("season_id = ?", p_season_id)
    else
      scoped
    end
  end

  def self.for_player(p_player_id)
    unless p_player_id.blank?
      where("player_id = ?", p_player_id)
    else
      scoped
    end
  end

  def self.with_status(p_status)
    case p_status
    when "paid"
      where('outstanding = ?', 0)
    when "outstanding"
      where('outstanding > ?', 0)
    when "refund"
      where('outstanding < ?', 0)
    else
      scoped
    end
  end

  def self.for_player_with_sex(p_sex)
    unless p_sex.blank?
      joins(:player).where("players.sex = ?", p_sex)
    else
      scoped
    end
  end
end
