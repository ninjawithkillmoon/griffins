module ReportsHelper
  def membership_types
    {"All Players" => :all, "Financial" => :financial, "Unfinancial" => :unfinancial}
  end

  def check_financial_status(p_status, p_invoice)
    case p_status
    when "all"
      return true
    when "financial"
      if p_invoice.outstanding <= 0.0
        return true
      end
    when "unfinancial"
      if p_invoice.outstanding > 0.0
        return true
      end
    end

    return false
  end
end
