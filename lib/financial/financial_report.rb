module Financial

  class FinancialReport
    @sectionsRevenue = {}
    @sectionsExpense = {}

    def initialize
      @sectionsRevenue = {}
      @sectionsExpense = {}
    end

    def addTransaction(p_parent, p_category, p_amount)
      if sections(p_amount)[p_parent].nil?

        section = FinancialReportSection.new(p_parent, p_amount >= 0.0)
        section.addTransaction(p_category, p_amount)

        sections(p_amount)[p_parent] = section
      else
        sections(p_amount)[p_parent].addTransaction(p_category, p_amount)
      end
    end

    # Checks that the section is the right type (revenue / expense) for the given amount.
    #
    # * *Args*    :
    #   - ++ -> 
    # * *Returns* :
    #   - 
    #
    def self.check_section_type?(p_section, p_amount)
      if p_section.revenue? && p_amount >= 0.0
        return true
      elsif p_section.expense? && p_amount < 0.0
        return true
      end

      return false
    end

    def sectionsRevenue
      @sectionsRevenue
    end

    def sectionsExpense
      @sectionsExpense
    end

    private #----------------------------------------------

    # Returns either @sectionsRevenue or @sectionsExpense depending on whether
    # p_amount is >= 0.0 or not. 
    #
    # * *Args*    :
    #   - ++ -> 
    # * *Returns* :
    #   - 
    #
    def sections(p_amount)
      if p_amount >= 0.0
        return @sectionsRevenue
      else
        return @sectionsExpense
      end
    end
  end

end