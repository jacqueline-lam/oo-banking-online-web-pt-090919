class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status 
  
  # Can initialize a Transfer with sender, receiver, amount, & status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end
  
  def valid?
    # check that both accounts are valid
    # calls on the sender and receiver's #valid? met
    @sender = BankAccount.all.find {|account| account == @sender}
    @receiver = BankAccount.all.find {|account| account == @receiver}
    return @sender.valid? && @receiver.valid?
  end
  
  # Execute a successful transaction between two accounts
  def execute_transaction
    # each transfer can only happen once
    if (@sender.balance > @amount) && (self.status == "pending") && (self.valid?)
      @sender.balance -= @amount
      @receiver.balance += @amount
      self.status = "complete"
    
    #rejects a transfer if the sender doesn't have enough funds 
    else  
      self.status = "rejected"
      p "Transaction rejected. Please check your account balance."
    end 
  end
      
      
end
