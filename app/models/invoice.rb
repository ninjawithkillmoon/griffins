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
  attr_accessible :amount, :notes, :outstanding, :outstanding_dollars, :payment_ids, :season_id, :player_id

  has_many :payments, dependent: :restrict
  belongs_to :season
  belongs_to :player

  #scope :for_season, lambda { |value| where('season_id = ?', value) unless value.blank? }
  #scope :for_player, lambda { |value| where('player_id = ?', value) unless value.blank? }

  before_save do |invoice|
    invoice.outstanding = invoice.amount if invoice.outstanding.nil?
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
    when :paid
      where('outstanding = ', 0.0)
    when :outstanding
      where('outstanding > ', 0.0)
    when :refund
      where('outstanding < ', 0.0)
    else
      scoped
    end
  end
end
