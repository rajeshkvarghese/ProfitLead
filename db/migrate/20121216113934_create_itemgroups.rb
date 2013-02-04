class CreateItemgroups < ActiveRecord::Migration
  def change
    create_table :itemgroups do |t|
      t.string :name
      t.string :code
      t.string :main_group
      t.string :tax
      t.decimal :discount_per
      t.string :description
      t.string :category
      t.string :print_only_sum
      t.string :print_name
      t.string :update_tax_child
      t.string :update_disc_child

      t.timestamps
    end
  end
end
