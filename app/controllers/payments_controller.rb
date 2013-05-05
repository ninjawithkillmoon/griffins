class PaymentsController < ApplicationController
  include PaymentsHelper, PlayersHelper, InvoicesHelper

  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Payments", :payments_path

  def index
    @payments = Payment.order("updated_at DESC").paginate(page: params[:page])
  end

  def show
    fetch_payment

    add_breadcrumb payment_code(@payment), @payment
  end

  def new
    @payment = Payment.new(params[:payment])

    add_breadcrumb "New", new_payment_path
  end

  def create
    @payment = Payment.new(params[:payment])

    add_breadcrumb "New", new_payment_path

    if @payment.save
      update_invoice_amount

      flash[:success] = t(:payment_created)
      redirect_to @payment
    else
      render 'new'
    end
  end

  def edit
    fetch_payment

    add_breadcrumb payment_code(@payment), @payment
    add_breadcrumb "Edit", edit_payment_path(@payment)
  end

  def update
    fetch_payment

    add_breadcrumb payment_code(@payment), @payment
    add_breadcrumb "Edit", edit_payment_path(@payment)

    if @payment.update_attributes(params[:payment])
      update_invoice_amount

      flash[:success] = t(:payment_updated)
      redirect_to @payment
    else
      render 'edit'
    end
  end

  def destroy
    fetch_payment

    @payment.destroy

    update_invoice_amount

    flash[:success] = t(:payment_deleted)
    redirect_to payments_path
  end

  private # ----------------------------------------------------------

  def fetch_payment
    @payment = Payment.find(params[:id])
  end

  def fetch_invoice
    @invoice = @payment.invoice
  end

  def update_invoice_amount
    @payment.invoice.recalculate_outstanding
    @payment.invoice.save!
  end
end
