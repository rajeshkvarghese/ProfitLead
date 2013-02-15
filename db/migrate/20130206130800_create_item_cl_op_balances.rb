class CreateItemClOpBalances < ActiveRecord::Migration
  def change
    create_table :item_cl_op_balances do |t|
      t.string :item_code
      t.string :year
      t.string :month
      t.text :opening_balances
      t.text :closing_balances
      t.string :month_opening_balance
      t.string :month_closing_balance

      t.timestamps
    end
  end
end
