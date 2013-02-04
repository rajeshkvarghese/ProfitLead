class CreateGeneraljournals < ActiveRecord::Migration
  def change
    create_table :generaljournals do |t|
      t.date :journal_date
      t.string :job
      t.decimal :dr_total
      t.decimal :cr_total
      t.decimal :amount
      t.text :narration

      t.timestamps
    end
  end
end
