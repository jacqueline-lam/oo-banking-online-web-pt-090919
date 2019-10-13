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
    @sender = BankAccount.all.find {|account| account == @sender}
    @receiver = BankAccount.all.find {|account| account == @receiver}
    # calls on the sender and receiver's #valid? met 
      # (account status open and +ve balance)
    return @sender.valid? && @receiver.valid?
  end
  
  # Execute a successful transaction between two accounts
  def execute_transaction
    # each transfer can only happen once
    if (@sender.balance > @amount) && (self.status == "pending") && (self.valid?)
      @sender.balance -= @amount
      @receiver.balance += @amount
      self.status = "complete"
    
    # rejects a transfer if the sender doesn't have enough funds 
    else  
      self.status = "rejected"
      p "Transaction rejected. Please check your account balance."
    end 
  end
  
  # Can reverse a transfer between two accounts
  def reverse_transfer
    
  end
      
      
  describe '#reverse_transfer' do
    it "can reverse a transfer between two accounts" do
      transfer.execute_transaction
      expect(amanda.balance).to eq(950)
      expect(avi.balance).to eq(1050)
      transfer.reverse_transfer
      expect(avi.balance).to eq(1000)
      expect(amanda.balance).to eq(1000)
      expect(transfer.status).to eq("reversed")
    end

    it "it can only reverse executed transfers" do
      transfer.reverse_transfer
      expect(amanda.balance).to eq(1000)
      expect(avi.balance).to eq(1000)
    end
  end
end
