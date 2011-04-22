# This is the controller which handles all of the transaction-related
# shenanigans. Again, mostly Rails boilerplate.
class TransactionsController < ApplicationController
  before_filter :require_user

  # GET /transactions
  # GET /transactions.xml
  # Shows an index listing all transactions.
  def index
    return false unless require_admin

    @transactions = Transaction.all
    
    unless current_user.is_super_admin?
      @transactions = @transactions.select{|t| t.item.lab == current_user.lab}
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # Shows an index of all transactions that share some status, such as all
  # pending transactions.
  def bystatus
    return false unless require_admin
    
    @transactions = Transaction.where(:status => params[:status].capitalize)

    unless current_user.is_super_admin?
      @transactions = @transactions.select{|t| t.item.lab == current_user.lab}
    end

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
      
      return false unless require_lab_admin(t.lab)

      if (params[:transaction_date]) then
        # Code here shamelessly stolen from the Internet
        # Instead of manually unpacking the date args, let Ruby do it
        t.due_date = Time.mktime(*params[:transaction_date] \
                                   .sort \
                                   .map(&:last) \
                                   .map(&:to_i))
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

      return false unless require_lab_admin(t.lab)

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
