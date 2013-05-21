module Financial

  class FinancialReport
    @sectionsRevenue = {}
    @sectionsExpense = {}
    @sectionsCombined = {}

    def initialize
      @sectionsRevenue = {}
      @sectionsExpense = {}
      @sectionsCombined = {}
    end

    def addTransaction(p_parent, p_category, p_amount)
      section = sections_by_amount(p_amount)[p_parent]

      if section.nil?
        section = FinancialReportSection.new(p_parent, p_amount >= 0.0)
      end

      section.addTransaction(p_category, p_amount)

      save_section(section)
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

    def sectionsCombined
      @sectionsCombined
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
    def sections_by_amount(p_amount)
      if p_amount >= 0.0
        return @sectionsRevenue
      else
        return @sectionsExpense
      end
    end

    def sections(p_revenue)
      if p_revenue
        return @sectionsRevenue
      else
        return @sectionsExpense
      end
    end

    def save_section(p_section)
      sections(p_section.revenue?)[p_section.name] = p_section

      if p_section.expense?
        @sectionsCombined["#{p_section.name}_expense"] = p_section
      elsif p_section.revenue?
        @sectionsCombined["#{p_section.name}_revenue"] = p_section
      end
    end
  end

end