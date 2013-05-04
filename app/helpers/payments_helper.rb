module PaymentsHelper
  def payment_code(p_payment)
    return "#{invoice_code(p_payment.invoice)}-P#{p_payment.id}"
  end

  def payment_type(p_method)
    case p_method
    when METHOD_TRANSFER
      return "Bank Transfer"
    when METHOD_CREDIT
      return "Credit Card"
    when METHOD_CASH
      return "Cash"
    when METHOD_CHEQUE
      return "Cheque"
    when METHOD_DISCOUNT
      return "Discount"
    end
  end
end
