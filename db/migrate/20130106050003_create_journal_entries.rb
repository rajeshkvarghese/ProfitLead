class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|
      t.integer :trans_rec_pay_journal_id
      t.date :journal_date
      t.string :account_head
      t.decimal :amount
      t.string :dr_cr
      t.string :trans_type
      t.string :master_leg
      t.text :description
      t.decimal :dr_amount
      t.decimal :cr_amount
      t.string :generaljournal_id
      t.string :other_account_head

      t.timestamps
    end
  end
end
