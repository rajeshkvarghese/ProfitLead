class CreateItemorders < ActiveRecord::Migration
  def change
    create_table :itemorders do |t|
      t.integer :invoice_id
      t.date :sales_date
      t.string :item_code
      t.string :item_name 
      t.float :quantity
      t.float :sales_rate_per_unit
      t.float :total
      t.float :discount_percentage
      t.float :final_total
      t.string :account_head
      t.string :other_account_head
      t.string :cash_credit
      t.string :transaction_name
      t.string :base_unit

      t.timestamps
    end
  end
end
