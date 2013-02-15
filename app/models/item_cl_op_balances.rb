class ItemClOpBalances < ActiveRecord::Base
  attr_accessible :closing_balances, :item_code, :month, :month_closing_balance, :month_opening_balance, :opening_balances, :year
end
