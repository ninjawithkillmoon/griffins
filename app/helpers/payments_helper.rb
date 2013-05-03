module PaymentsHelper
  def payment_name(p_payment)
    "#{full_name(p_payment.invoice.player)} - Payment #{p_payment.id}"
  end
end
