class VoucherExtraData < ActiveRecord::Base
  attr_accessible :ledger_balances, :voucher_no, :item_balances
end
