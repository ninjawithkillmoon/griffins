class TransactionsController < ApplicationController
  include TransactionsHelper, PlayersHelper, InvoicesHelper

  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  add_breadcrumb "Transactions", :transactions_path

  def index
    @transactions = Transaction.order("paid_at DESC").paginate(page: params[:page])

    @total = @transactions.total_entries
  end

  def show
    fetch_transaction

    add_breadcrumb @transaction.code, @transaction
  end

  def new
    @transaction = Transaction.new(params[:transaction])
    fetch_categories_with_parents

    add_breadcrumb "New", new_transaction_path
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    fetch_categories_with_parents

    add_breadcrumb "New", new_transaction_path

    if @transaction.save
      flash[:success] = t(:transaction_created)
      redirect_to @transaction
    else
      render 'new'
    end
  end

  def edit
    fetch_transaction
    fetch_categories_with_parents

    add_breadcrumb @transaction.code, @transaction
    add_breadcrumb "Edit", edit_transaction_path(@transaction)
  end

  def update
    fetch_transaction
    fetch_categories_with_parents

    add_breadcrumb @transaction.code, @transaction
    add_breadcrumb "Edit", edit_transaction_path(@transaction)

    if @transaction.update_attributes(params[:transaction])
      flash[:success] = t(:transaction_updated)
      redirect_to @transaction
    else
      render 'edit'
    end
  end

  def destroy
    fetch_transaction

    @transaction.destroy

    flash[:success] = t(:transaction_deleted)
    redirect_to transactions_path
  end

  private # ----------------------------------------------------------

  def fetch_transaction
    @transaction = Transaction.find(params[:id])
  end

  def fetch_categories_with_parents
    @categories_with_parents = TransactionCategory.where("parent_id IS NOT NULL").includes(:parent).sort_by! { |cat| [cat.parent.name, cat.name] }
  end
end
