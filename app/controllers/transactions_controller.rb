# This is the controller which handles all of the transaction-related
# shenanigans. Again, mostly Rails boilerplate.
class TransactionsController < ApplicationController
  before_filter :require_user

  # GET /transactions
  # GET /transactions.xml
  # Shows an index listing all transactions.
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # Shows an index of all transactions that share some status, such as all
  # pending transactions.
  def bystatus
    @transactions = Transaction.where(:status => params[:status].capitalize)

    respond_to do |format|
      format.html
      format.xml
    end
  end

  # Approves a transaction. Only admins should be able to call this method,
  # directly or indirectly.
  def approve
    puts params.inspect
    if params[:transaction_id] then
      t = Transaction.find(params[:transaction_id])
      if (params[:transaction][:due_date]) then
        t.due_date = params[:transaction][:due_date]
      end
      t.status = "Complete"
      t.save
      t.approve
      redirect_to transactions_path
    end
  end

  # Rejects the current transaction. The code is largely similar to
  # TransactionsController#approve; it just merely sets a different status and
  # calls Transaction#cancel instead.
  def reject
    if params[:transaction_id] then
      t = Transaction.find(params[:transaction_id])
      t.status = "Cancelled"
      t.save
      t.cancel
      redirect_to transactions_path
    end
  end

  # POST /transactions
  # POST /transactions.xml
  # Creates a new transaction.
  def create
    if params[:item_id] then  # We're coming from an item page
      item = Item.find(params[:item_id])
      transaction = item.transactions.create(params[:transaction])
      path = item_path(item)
    elsif params[:user_id] then  # We're coming from a user page
      user = User.find_by_username(params[:user_id])
      transaction = user.transactions.create(params[:transaction])
      path = user_path(user)
    end

    if transaction then
      # What we got was a generic Transaction; we want the subclass
      # so that polymorphism can do its thing
      transaction = transaction.becomes(transaction.class_type.constantize)
      transaction.created
      redirect_to path
    end
  end

end
