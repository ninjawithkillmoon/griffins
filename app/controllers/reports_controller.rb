class ReportsController < ApplicationController
  include ReportsHelper

  before_filter :signed_in_user

  def financial
    validate_input_financial
    fetch_transactions
    calculate_balances
    make_report

    add_breadcrumb 'Financial Report', '/reports/financial'
  end

  def membership
    fetch_seasons
    validate_input_membership
    fetch_season
    fetch_invoices

    add_breadcrumb 'Membership Report', '/reports/membership'

    respond_to do |format|
      format.html
      format.csv { send_data membership_csv(@invoices) }
    end
  end

  private # ----------------------------------------------------------

  def validate_input_financial
    if params[:date_start].nil?
      params[:date_start] = Date.today.beginning_of_year
    end

    if params[:date_end].nil?
      params[:date_end] = Date.today.end_of_year
    end

    @hideBalance = params[:hide_balance] == "true"
  end

  def validate_input_membership
    #bare layout

    if params[:status].nil?
      params[:status] = :all
    end

    if params[:season_id].nil?
      params[:season_id] = @seasons.first.id
    end

    @status = params[:status]
  end

  def fetch_transactions
    @transactionsDuring = Transaction.after_inclusive(params[:date_start])
                                     .before_inclusive(params[:date_end])

    @transactionsBefore = Transaction.before(params[:date_start])
  end

  #def fetch_players
  #  @players = Player.joins({:teams => {:division => :season}}).where("season_id = ?", @season_id).order("name_family ASC, name_given ASC")
  #end

  def fetch_seasons
    @seasons = Season.order("date_start DESC")
  end

  def fetch_season
    @season = Season.find(params[:season_id])
  end

  def fetch_invoices
    invoices_all = Invoice.joins(:player).where("season_id = ?", @season.id).order("players.name_family, players.name_given")

    @invoices = []

    @countMale = 0
    @countFemale = 0

    @countStudentMale = 0
    @countStudentFemale = 0

    invoices_all.each do |invoice|
      if check_financial_status @status, invoice
        @invoices.push invoice

        if invoice.player.male?
          @countMale += 1
          if invoice.player.student?
            @countStudentMale += 1
          end
        else
          @countFemale += 1
          if invoice.player.student?
            @countStudentFemale += 1
          end
        end
      end
    end

    @countTotal = @countMale + @countFemale
    @countStudentTotal = @countStudentMale + @countStudentFemale
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

    @balanceDiff = @balanceAfter - @balanceBefore
  end

  def make_report
    @report = Financial::FinancialReport.new

    @transactionsDuring.each do |t|
      @report.addTransaction(t.category.parent.name, t.category.name, t.amount_dollars)
    end
  end

  def determine_layout
    if params[:action] == 'membership' && params[:format] == :pdf
      return 'application'
    else
      return 'application'
    end
  end

end
