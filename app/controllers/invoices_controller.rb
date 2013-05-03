class InvoicesController < ApplicationController
  include InvoicesHelper, PlayersHelper

  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Invoices", :invoices_path

  def index
    fetch_invoices
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

    add_breadcrumb invoice_name(@invoice), @invoice
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
      flash[:error] = "Error: Cannot delete invoice with existing payments. Please remove payments separately or contact an administrator"
    ensure
      redirect_to invoices_path
    end
  end

  private # ----------------------------------------------------------

  def fetch_invoice
    @invoice = Invoice.find(params[:id])
  end

  def fetch_invoices
    @invoices = Invoice.order("updated_at").paginate(page: params[:page])
  end
end
