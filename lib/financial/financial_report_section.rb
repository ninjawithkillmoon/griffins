module Financial

  class FinancialReportSection
    @revenue = true
    @name = ''
    @lines = {}

    def initialize(p_name, p_revenue)
      @revenue = p_revenue
      @name = p_name
      @lines = {}
    end

    def addTransaction(p_category, p_amount)
      if (@revenue && p_amount < 0.0) || (!@revenue && p_amount >= 0.0)
        raise Exception, 'Amount must match type: revenue or expense'
      end

      if @lines[p_category].nil?
        @lines[p_category] = p_amount
      else
        @lines[p_category] += p_amount
      end
    end

    def total
      total = Money.new(0)

      @lines.each do |name, amount|
        total += amount
      end

      return total
    end

    def name
      @name
    end

    def lines
      @lines
    end

    def revenue?
      @revenue
    end

    def expense?
      !@revenue
    end

    def row_class
      case @revenue
      when true
        return "success"
      when false
        return "error"
      end
    end
  end

end