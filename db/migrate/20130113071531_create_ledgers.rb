class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.string :is_active
      t.string :name
      t.string :short_name
      t.string :code
      t.string :group
      t.decimal :opening_balance
      t.string :dr_cr
      t.decimal :current_balance
      t.string :set_as_party
      t.string :name_to_print
      t.text :comments
      t.text :office_addr_bill_to
      t.string :office_city
      t.string :office_district
      t.string :office_state
      t.string :office_country
      t.string :office_pin_code
      t.string :office_website
      t.string :office_contact_person
      t.string :office_designation
      t.string :office_phone
      t.string :office_fax
      t.string :office_mobile_no
      t.string :office_email_id
      t.string :tin_no
      t.string :cst_no
      t.string :acct_no
      t.string :bank_name
      t.string :bank_ifsc
      t.string :bank_branch
      t.string :license_no
      t.string :rate
      t.string :currency
      t.string :central_excise_no
      t.string :salesman
      t.string :income_tax_no
      t.string :use_voucher
      t.decimal :discount_percentage
      t.integer :credit_period
      t.decimal :maximum_credit_limit
      t.decimal :maximum_debit_limit
      t.string :stop_if_period_exceed
      t.string :stop_if_amount_exceed
      t.string :segment
      t.string :grade
      t.string :fleet_order
      t.text :dely_addr_ship_to
      t.string :dely_city
      t.string :dely_district
      t.string :dely_state
      t.string :dely_country
      t.string :dely_pin_code
      t.string :dely_website
      t.string :dely_contact_person
      t.string :dely_designation
      t.string :dely_phone
      t.string :dely_fax
      t.string :dely_mobile_no
      t.string :dely_email_id
      t.string :dely_add_same_cont

      t.timestamps
    end
  end
end
