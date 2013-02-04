# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130128050514) do

  create_table "accountgroups", :force => true do |t|
    t.string   "group_name"
    t.string   "parent_group", :null => false
    t.string   "book_type"
    t.integer  "schedule_no"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "accountgroups", ["group_name"], :name => "group_name_UNIQUE", :unique => true

  create_table "customers", :force => true do |t|
    t.string   "is_active",             :limit => 20
    t.string   "name",                                                                :null => false
    t.string   "short_name",            :limit => 50
    t.string   "code",                  :limit => 50
    t.string   "group",                 :limit => 50
    t.decimal  "opening_balance",                      :precision => 18, :scale => 2
    t.string   "dr_cr",                 :limit => 45
    t.decimal  "current_balance",                      :precision => 18, :scale => 2
    t.string   "set_as_party",          :limit => 50
    t.string   "name_to_print"
    t.text     "comments"
    t.text     "cont_addr_bill_to"
    t.string   "cont_city",             :limit => 50
    t.string   "cont_district",         :limit => 50
    t.string   "cont_state",            :limit => 50
    t.string   "cont_country",          :limit => 100
    t.string   "cont_pin_code",         :limit => 45
    t.string   "cont_website"
    t.string   "cont_contact_person",   :limit => 100
    t.string   "cont_designation",      :limit => 100
    t.string   "cont_phone",            :limit => 50
    t.string   "cont_fax",              :limit => 50
    t.string   "cont_mobile_no",        :limit => 100
    t.string   "cont_email_id",         :limit => 50
    t.string   "tin_no",                :limit => 50
    t.string   "cst_no",                :limit => 50
    t.string   "acct_no",               :limit => 50
    t.string   "bank_name",             :limit => 50
    t.string   "bank_ifsc",             :limit => 50
    t.string   "bank_branch",           :limit => 50
    t.string   "license_no",            :limit => 100
    t.string   "rate",                  :limit => 50
    t.string   "currency",              :limit => 50
    t.string   "central_excise_no",     :limit => 50
    t.string   "salesman",              :limit => 50
    t.string   "income_tax_no",         :limit => 100
    t.string   "use_voucher",           :limit => 45
    t.decimal  "discount_percentage",                  :precision => 5,  :scale => 2
    t.integer  "credit_period"
    t.decimal  "maximum_credit_limit",                 :precision => 18, :scale => 2
    t.decimal  "maximum_debit_limit",                  :precision => 18, :scale => 2
    t.string   "stop_if_period_exceed", :limit => 45
    t.string   "stop_if_amount_exceed", :limit => 45
    t.string   "segment",               :limit => 45
    t.string   "grade",                 :limit => 45
    t.string   "fleet_order",           :limit => 45
    t.text     "dely_addr_ship_to"
    t.string   "dely_city",             :limit => 50
    t.string   "dely_district",         :limit => 50
    t.string   "dely_state",            :limit => 50
    t.string   "dely_country",          :limit => 100
    t.string   "dely_pin_code",         :limit => 45
    t.string   "dely_website"
    t.string   "dely_contact_person",   :limit => 100
    t.string   "dely_designation",      :limit => 100
    t.string   "dely_phone",            :limit => 50
    t.string   "dely_fax",              :limit => 50
    t.string   "dely_mobile_no",        :limit => 100
    t.string   "dely_email_id",         :limit => 50
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "dely_add_same_cont",    :limit => 45
  end

  add_index "customers", ["id"], :name => "id_UNIQUE", :unique => true
  add_index "customers", ["name"], :name => "name_UNIQUE", :unique => true

  create_table "data_configs", :force => true do |t|
    t.string   "ledger_designation_list", :limit => 1000
    t.string   "ledger_area_list",        :limit => 1000
    t.string   "ledger_salesman_list",    :limit => 1000
    t.string   "ledger_use_voucher_list", :limit => 1000
    t.string   "ledger_rate_used_list",   :limit => 1000
    t.string   "ledger_grade_list",       :limit => 1000
    t.string   "ledger_fleetorder_list",  :limit => 1000
    t.string   "ledger_segment_list",     :limit => 1000
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "item_base_unit",          :limit => 1000
  end

  create_table "generaljournals", :force => true do |t|
    t.date     "journal_date"
    t.string   "job"
    t.decimal  "dr_total",     :precision => 10, :scale => 2
    t.decimal  "cr_total",     :precision => 10, :scale => 2
    t.decimal  "amount",       :precision => 10, :scale => 2
    t.text     "narration"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "invoices", :force => true do |t|
    t.date     "invoice_date",                                                    :null => false
    t.string   "customer_name"
    t.text     "bill_to_address"
    t.text     "ship_to_address"
    t.decimal  "sub_total",                        :precision => 18, :scale => 2
    t.decimal  "vat",                              :precision => 18, :scale => 2
    t.decimal  "total",                            :precision => 18, :scale => 2
    t.decimal  "Paid",                             :precision => 18, :scale => 2
    t.decimal  "balance",                          :precision => 18, :scale => 2
    t.text     "comments"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.string   "cash_credit",        :limit => 45,                                :null => false
    t.string   "account_head",                                                    :null => false
    t.string   "transaction_name",   :limit => 45,                                :null => false
    t.string   "other_account_head",                                              :null => false
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "address_line_4"
    t.string   "address_line_5"
    t.string   "address_line_6"
    t.string   "phone",              :limit => 45
    t.string   "email",              :limit => 45
  end

  add_index "invoices", ["id"], :name => "id_UNIQUE", :unique => true

  create_table "itemgroups", :force => true do |t|
    t.string   "name",                                                            :null => false
    t.string   "code",              :limit => 50,                                 :null => false
    t.string   "main_group",        :limit => 50
    t.string   "tax",               :limit => 50
    t.decimal  "discount_per",                     :precision => 10, :scale => 2
    t.string   "description",       :limit => 100
    t.string   "category",          :limit => 50
    t.string   "print_only_sum",    :limit => 50
    t.string   "print_name",        :limit => 100
    t.string   "update_tax_child",  :limit => 50
    t.string   "update_disc_child", :limit => 50
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  add_index "itemgroups", ["code"], :name => "code_UNIQUE", :unique => true

  create_table "itemorders", :force => true do |t|
    t.integer  "invoice_id",                                                                            :null => false
    t.date     "sales_date"
    t.string   "item_code",                                                                             :null => false
    t.string   "item_name"
    t.decimal  "quantity",                           :precision => 18, :scale => 2
    t.decimal  "sales_rate_per_unit",                :precision => 18, :scale => 2
    t.decimal  "total",                              :precision => 18, :scale => 2
    t.decimal  "discount_percentage",                :precision => 18, :scale => 2
    t.decimal  "final_total",                        :precision => 18, :scale => 2
    t.datetime "created_at",                                                                            :null => false
    t.datetime "updated_at",                                                                            :null => false
    t.string   "account_head",        :limit => 225,                                                    :null => false
    t.string   "other_account_head",  :limit => 225,                                                    :null => false
    t.string   "cash_credit",         :limit => 45,                                                     :null => false
    t.string   "transaction_name",    :limit => 45,                                                     :null => false
    t.string   "base_unit",           :limit => 45,                                                     :null => false
    t.string   "vat_account",         :limit => 45,                                 :default => "0.00", :null => false
    t.integer  "quantity_on_hand",                                                                      :null => false
    t.decimal  "discount_amount",                    :precision => 18, :scale => 2, :default => 0.0
    t.decimal  "tax_amount",                         :precision => 18, :scale => 2, :default => 0.0,    :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "code",                    :limit => 50,                                                  :null => false
    t.string   "alias",                   :limit => 50
    t.string   "name",                                                                                   :null => false
    t.string   "group",                   :limit => 100
    t.string   "base_unit",               :limit => 50
    t.integer  "opening_quantity",                                                      :default => 0
    t.integer  "quantity_on_hand",                                                      :default => 0
    t.decimal  "opening_stock_value",                    :precision => 18, :scale => 2, :default => 0.0
    t.integer  "reorder_level"
    t.integer  "indicator_level"
    t.string   "manufacturer",            :limit => 100
    t.string   "category",                :limit => 50
    t.decimal  "max_retail_price",                       :precision => 18, :scale => 2
    t.string   "hsn_code",                :limit => 50
    t.decimal  "min_retail_price",                       :precision => 18, :scale => 2
    t.string   "ean_code",                :limit => 50
    t.decimal  "purchase_rate",                          :precision => 18, :scale => 2
    t.string   "vat_account",             :limit => 50
    t.decimal  "sales_rate",                             :precision => 18, :scale => 2
    t.string   "costing",                 :limit => 50
    t.decimal  "other_rate",                             :precision => 18, :scale => 2
    t.integer  "pack_numbers"
    t.decimal  "market_rate",                            :precision => 18, :scale => 2
    t.decimal  "discount_percentage",                    :precision => 18, :scale => 2, :default => 0.0
    t.text     "comments"
    t.string   "update_stock_with_bonus", :limit => 45
    t.string   "is_active",               :limit => 45
    t.string   "set_as_container",        :limit => 45
    t.datetime "created_at",                                                                             :null => false
    t.datetime "updated_at",                                                                             :null => false
    t.decimal  "discount_amount",                        :precision => 18, :scale => 2
    t.decimal  "tax_amount",                             :precision => 18, :scale => 2
  end

  add_index "items", ["alias"], :name => "alias_UNIQUE", :unique => true
  add_index "items", ["code"], :name => "item_code_UNIQUE", :unique => true

  create_table "journal_entries", :force => true do |t|
    t.integer  "trans_rec_pay_journal_id"
    t.date     "journal_date"
    t.string   "account_head"
    t.string   "other_account_head"
    t.decimal  "amount",                                 :precision => 10, :scale => 2
    t.string   "dr_cr"
    t.string   "trans_type"
    t.string   "master_leg"
    t.text     "description"
    t.decimal  "dr_amount",                              :precision => 10, :scale => 2
    t.decimal  "cr_amount",                              :precision => 10, :scale => 2
    t.string   "generaljournal_id",        :limit => 45
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
  end

  create_table "ledger_cl_op_balances", :force => true do |t|
    t.string   "ledger_name"
    t.string   "year"
    t.string   "month"
    t.text     "opening_balances"
    t.text     "closing_balances"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "ledgers", :force => true do |t|
    t.string   "is_active",             :limit => 50
    t.string   "name",                                                               :null => false
    t.string   "short_name"
    t.string   "code"
    t.string   "group"
    t.decimal  "opening_balance",                     :precision => 18, :scale => 2
    t.string   "dr_cr"
    t.decimal  "current_balance",                     :precision => 18, :scale => 2
    t.string   "set_as_party"
    t.string   "name_to_print"
    t.text     "comments"
    t.text     "office_addr_bill_to"
    t.string   "office_city"
    t.string   "office_district"
    t.string   "office_state"
    t.string   "office_country"
    t.string   "office_pin_code"
    t.string   "office_website"
    t.string   "office_contact_person"
    t.string   "office_designation"
    t.string   "office_phone"
    t.string   "office_fax"
    t.string   "office_mobile_no"
    t.string   "office_email_id"
    t.string   "tin_no"
    t.string   "cst_no"
    t.string   "acct_no"
    t.string   "bank_name"
    t.string   "bank_ifsc"
    t.string   "bank_branch"
    t.string   "license_no"
    t.string   "rate"
    t.string   "currency"
    t.string   "central_excise_no"
    t.string   "salesman"
    t.string   "income_tax_no"
    t.string   "use_voucher"
    t.decimal  "discount_percentage",                 :precision => 18, :scale => 2
    t.integer  "credit_period"
    t.decimal  "maximum_credit_limit",                :precision => 18, :scale => 2
    t.decimal  "maximum_debit_limit",                 :precision => 18, :scale => 2
    t.string   "stop_if_period_exceed"
    t.string   "stop_if_amount_exceed"
    t.string   "segment"
    t.string   "grade"
    t.string   "fleet_order"
    t.text     "dely_addr_ship_to"
    t.string   "dely_city"
    t.string   "dely_district"
    t.string   "dely_state"
    t.string   "dely_country"
    t.string   "dely_pin_code"
    t.string   "dely_website"
    t.string   "dely_contact_person"
    t.string   "dely_designation"
    t.string   "dely_phone"
    t.string   "dely_fax"
    t.string   "dely_mobile_no"
    t.string   "dely_email_id"
    t.string   "dely_add_same_cont"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  add_index "ledgers", ["id"], :name => "id_UNIQUE", :unique => true
  add_index "ledgers", ["name"], :name => "name_UNIQUE", :unique => true

  create_table "trans_rec_pay_journals", :force => true do |t|
    t.date     "journal_date"
    t.string   "account_head"
    t.decimal  "amount",                           :precision => 10, :scale => 2
    t.string   "dr_cr",              :limit => 45
    t.text     "narration"
    t.string   "cheque_no"
    t.date     "cheque_date"
    t.string   "recd_paid_from_to"
    t.text     "cheque_description"
    t.string   "approve"
    t.string   "verify"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "user",                   :default => ""
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
