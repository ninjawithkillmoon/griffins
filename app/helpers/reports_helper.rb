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

  def membership_csv(p_invoices, p_options = {})
    CSV.generate(p_options) do |csv|
      csv << ['Sex', 'Family Name', 'Given Name', 'Email', 'Student Number']
      
      p_invoices.each do |invoice|
        csv << [invoice.player.sex_string, invoice.player.name_family, invoice.player.name_given, invoice.player.email, invoice.player.student_number_if_student]
      end
    end
  end

  def uniform_numbers_csv(p_players, p_spare_uniforms, p_options = {})
    CSV.generate(p_options) do |csv|
      csv << ['Number', 'Player', 'Additional Player', 'Additional Player']

      for number in 0..99
        csv << [number]
               .concat(p_players.select{ |player| player.number == number }.map{ |player| player.full_name })
               .concat(p_spare_uniforms.select{ |spare| spare.number == number }.map{ |spare| "Spare Uniform" })
      end
    end
  end
end
