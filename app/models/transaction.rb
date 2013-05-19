# == Schema Information
#
# Table name: transactions
#
#  id          :integer          not null, primary key
#  credit      :boolean
#  method      :string(255)
#  amount      :decimal(, )
#  notes       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  invoice_id  :integer
#  category_id :integer
#

class Transaction < ActiveRecord::Base
  attr_accessible :amount, :amount_dollars, :credit, :method, :notes, :invoice_id, :category_id, :paid_at

  belongs_to :invoice
  belongs_to :category, class_name: "TransactionCategory"

  before_save do |transaction|
    unless transaction.credit?
      transaction.amount = 0 - transaction.amount
    end
  end

  after_save do |transaction|
    recalculate_outstanding(transaction)
  end

  after_destroy do |transaction|
    recalculate_outstanding(transaction)
  end

  validates(:amount, {
      presence: true,
    }
  )

  validates(:method, {
      presence: true
    }
  )

  validates(:category, {
      presence: true,
    }
  )

  validates(:credit, {
      inclusion: {in: [true, false]},
    }
  )

  validates(:paid_at, {
      presence: true,
    }
  )

  monetize :amount, as: :amount_dollars

  METHOD_CASH     = "Cash"
  METHOD_CHEQUE   = "Cheque"
  METHOD_CREDIT   = "Credit"
  METHOD_TRANSFER = "Transfer"

  METHODS = [METHOD_CASH, METHOD_CHEQUE, METHOD_CREDIT, METHOD_TRANSFER]

  def code
    return "t#{id}-#{type_string}"
  end

  def type_string
    if credit?
      return "credit"
    else
      return "debit"
    end
  end

  def self.after(p_date)
    unless p_date.blank?
      where("paid_at > ?", p_date)
    else
      scoped
    end
  end

  def self.after_inclusive(p_date)
    unless p_date.blank?
      where("paid_at >= ?", p_date)
    else
      scoped
    end
  end

  def self.before(p_date)
    unless p_date.blank?
      where("paid_at < ?", p_date)
    else
      scoped
    end
  end

  def self.before_inclusive(p_date)
    unless p_date.blank?
      where("paid_at <= ?", p_date)
    else
      scoped
    end
  end

  def self.sum()
    select("sum(amount_dollars) as total")
  end

  private # ----------------------------------------------------------

  def recalculate_outstanding(p_transaction)
    unless p_transaction.invoice.nil?
      p_transaction.invoice.recalculate_outstanding
      p_transaction.invoice.save!
    end
  end
end
