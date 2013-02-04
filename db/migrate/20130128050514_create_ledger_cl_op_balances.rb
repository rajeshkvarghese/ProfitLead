class CreateLedgerClOpBalances < ActiveRecord::Migration
  def change
    create_table :ledger_cl_op_balances do |t|
        t.string :ledger_name
        t.string :year
        t.string :month
        t.text :opening_balances
        t.text :closing_balances
        
        t.timestamps
        
      t.timestamps
    end
  end
end
