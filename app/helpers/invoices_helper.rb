module InvoicesHelper
  def invoice_name(p_invoice)
    "#{full_name(p_invoice.player)} - #{p_invoice.id}"
  end
end
