class CreateAccountgroups < ActiveRecord::Migration
  def change
    create_table :accountgroups do |t|
      t.string :group_name
      t.string :parent_group
      t.string :book_type
      t.integer :schedule_no

      t.timestamps
    end
  end
end
