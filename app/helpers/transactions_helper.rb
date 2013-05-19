module TransactionsHelper
  def transaction_row_class(p_transaction)
    case
    when p_transaction.credit?
      return "success"
    else
      return "error"
    end
  end
end
