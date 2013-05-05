class InvoicesController < ApplicationController
  include InvoicesHelper, PlayersHelper

  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Invoices", :invoices_path

  def index
    fetch_invoices
    fetch_seasons
    fetch_players
  end

  def show
    fetch_invoice

    add_breadcrumb invoice_code(@invoice), @invoice
  end

  def new
    @invoice = Invoice.new

    add_breadcrumb "New", new_invoice_path
  end

  def create
    @invoice = Invoice.new(params[:invoice])

    add_breadcrumb "New", new_invoice_path

    if @invoice.save
      flash[:success] = t(:invoice_created)
      redirect_to @invoice
    else
      render 'new'
    end
  end

  def edit
    fetch_invoice

    add_breadcrumb invoice_code(@invoice), @invoice
    add_breadcrumb "Edit", edit_invoice_path(@invoice)
  end

  def update
    fetch_invoice

    add_breadcrumb invoice_code(@invoice), @invoice
    add_breadcrumb "Edit", edit_invoice_path(@invoice)

    if @invoice.update_attributes(params[:invoice])
      flash[:success] = t(:invoice_updated)
      redirect_to @invoice
    else
      render 'edit'
    end
  end

  def destroy
    fetch_invoice

    begin
      @invoice.destroy
      flash[:success] = t(:invoice_deleted)
    rescue
      flash[:error] = "Error: Cannot delete invoice with existing payments. Please remove payments separately or contact an administrator."
    ensure
      redirect_to invoices_path
    end
  end

  private # ----------------------------------------------------------

  def fetch_invoice
    @invoice = Invoice.find(params[:id])
  end

  def fetch_invoices
    @invoices = Invoice.for_season(params[:season_id])
                       .for_player(params[:player_id])
                       .with_status(params[:status])
                       .for_player_with_sex(params[:sex])
                       .includes(:player)
                       .order("invoices.updated_at DESC")
                       .paginate(page: params[:page])
  end

  def fetch_seasons
    @seasons = Season.order("date_start DESC")
  end

  def fetch_players
    @players = Player.order("name_family, name_given")
  end
end
