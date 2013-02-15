class CreateVoucherExtraData < ActiveRecord::Migration
  def change
    create_table :voucher_extra_data do |t|
      t.string :voucher_no
      t.string :ledger_balances

      t.timestamps
    end
  end
end
