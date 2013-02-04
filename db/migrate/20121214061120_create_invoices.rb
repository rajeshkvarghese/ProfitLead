class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|     
      t.datetime :invoice_date
      t.string :customer_name
      t.text :bill_to_address
      t.text :ship_to_address     
      t.float :sub_total
      t.float :vat
      t.float :total
      t.float :Paid
      t.float :balance
      t.text :comments
      t.string :cash_credit 
      t.string :account_head
      t.string :transaction_name
      t.string :other_account_head 
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :address_line_4
      t.string :address_line_5
      t.string :address_line_6
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
