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

  def membership_csv(p_invoices, options = {})
    CSV.generate(options) do |csv|
      csv << ['Sex', 'Family Name', 'Given Name', 'Email', 'Student Number']
      p_invoices.each do |invoice|
        csv << [invoice.player.sex_string, invoice.player.name_family, invoice.player.name_given, invoice.player.email, invoice.player.student_number_if_student]
      end
    end
  end
end
