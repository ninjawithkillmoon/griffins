module InvoicesHelper
  def invoice_code(p_invoice)
    given = p_invoice.player.name_given
    family = p_invoice.player.name_family

    year = p_invoice.created_at.in_time_zone(LOCAL_TIMEZONE).year
    unless p_invoice.season.nil?
      year = p_invoice.season.date_start.year
    end

    return "#{family.upcase}#{given.upcase}-#{year}-#{p_invoice.id}"
  end

  def invoice_row_class(p_invoice)
    case
    when p_invoice.outstanding < 0.0
      return "info"
    when p_invoice.outstanding == 0.0
      return "success"
    when p_invoice.outstanding >= p_invoice.amount
      return "error"
    when p_invoice.outstanding > 0.0
      return "warning"
    end
  end

  def status_types
    {"Paid" => :paid, "Outstanding" => :outstanding, "Refund Required" => :refund}
  end


end
