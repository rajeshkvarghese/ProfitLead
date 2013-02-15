class LedgerClOpBalances < ActiveRecord::Base
  # attr_accessible :title, :body
  
  attr_accessible :ledger_name, :year, :month, :opening_balances, :closing_balances, 
  :month_opening_balance, :month_closing_balance
  
end
