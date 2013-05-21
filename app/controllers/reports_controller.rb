class ReportsController < ApplicationController

  before_filter :signed_in_user

  def financial
    validate_input
    fetch_transactions
    calculate_balances
    make_report
  end

  private # ----------------------------------------------------------

  def validate_input
    if params[:date_start].nil?
      params[:date_start] = Date.today.beginning_of_year
    end

    if params[:date_end].nil?
      params[:date_end] = Date.today.end_of_year
    end
  end

  def fetch_transactions
    @transactionsDuring = Transaction.after_inclusive(params[:date_start])
                                     .before_inclusive(params[:date_end])

    @transactionsBefore = Transaction.before(params[:date_start])
  end

  def calculate_balances
    @balanceBefore = Money.new(0)

    @transactionsBefore.each do |t|
      @balanceBefore += t.amount_dollars
    end

    @balanceAfter = @balanceBefore

    @transactionsDuring.each do |t|
      @balanceAfter += t.amount_dollars
    end
  end

  def make_report
    @report = Financial::FinancialReport.new

    @transactionsDuring.each do |t|
      @report.addTransaction(t.category.parent.name, t.category.name, t.amount_dollars)
    end
  end

end
