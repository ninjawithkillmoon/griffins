class Payment < ActiveRecord::Base
  attr_accessible :amount, :method, :notes, :invoice_id

  belongs_to :invoice
end
