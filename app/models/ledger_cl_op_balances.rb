class LedgerClOpBalances < ActiveRecord::Base
  # attr_accessible :title, :body
  
  attr_accessible :ledger_name, :year, :month, :opening_balances, :closing_balances
  
end
