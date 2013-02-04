class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_code
      t.string :item_name
      t.float :purchase_rate
      t.float :sales_rate
      t.float :discount_perc    
      t.decimal :discount_amount
      t.decimal :tax_amount

      t.timestamps
    end
  end
end
