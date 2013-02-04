class CreateTransRecPayJournals < ActiveRecord::Migration
  def change
    create_table :trans_rec_pay_journals do |t|
      t.date :journal_date
      t.string :account_head
      t.text :narration
      t.string :cheque_no
      t.date :cheque_date
      t.string :recd_paid_from_to
      t.text :cheque_description
      t.string :approve
      t.string :verify
      t.decimal :amount
      t.string :dr_cr

      t.timestamps
    end
  end
end
