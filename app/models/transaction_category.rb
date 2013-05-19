# == Schema Information
#
# Table name: transaction_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TransactionCategory < ActiveRecord::Base
  attr_accessible :name, :parent_id

  belongs_to :parent, class_name: "TransactionCategory", foreign_key: "parent_id"
  has_many :children, class_name: "TransactionCategory", foreign_key: "parent_id"

  validates(:name, {
      presence: true,
    }
  )
end
