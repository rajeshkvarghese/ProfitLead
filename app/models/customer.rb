# == Schema Information
#
# Table name: customers
#
#  id                    :integer          not null, primary key
#  is_active             :string(20)
#  name                  :string(255)      not null
#  short_name            :string(50)
#  code                  :string(50)
#  group                 :string(50)
#  opening_balance       :decimal(18, 2)
#  dr_cr                 :string(45)
#  current_balance       :decimal(18, 2)
#  set_as_party          :string(50)
#  name_to_print         :string(255)
#  comments              :text
#  cont_addr_bill_to     :text
#  cont_city             :string(50)
#  cont_district         :string(50)
#  cont_state            :string(50)
#  cont_country          :string(100)
#  cont_pin_code         :string(45)
#  cont_website          :string(255)
#  cont_contact_person   :string(100)
#  cont_designation      :string(100)
#  cont_phone            :string(50)
#  cont_fax              :string(50)
#  cont_mobile_no        :string(100)
#  cont_email_id         :string(50)
#  tin_no                :string(50)
#  cst_no                :string(50)
#  acct_no               :string(50)
#  bank_name             :string(50)
#  bank_ifsc             :string(50)
#  bank_branch           :string(50)
#  license_no            :string(100)
#  rate                  :string(50)
#  currency              :string(50)
#  central_excise_no     :string(50)
#  salesman              :string(50)
#  income_tax_no         :string(100)
#  use_voucher           :string(45)
#  discount_percentage   :decimal(5, 2)
#  credit_period         :integer
#  maximum_credit_limit  :decimal(18, 2)
#  maximum_debit_limit   :decimal(18, 2)
#  stop_if_period_exceed :string(45)
#  stop_if_amount_exceed :string(45)
#  segment               :string(45)
#  grade                 :string(45)
#  fleet_order           :string(45)
#  dely_addr_ship_to     :text
#  dely_city             :string(50)
#  dely_district         :string(50)
#  dely_state            :string(50)
#  dely_country          :string(100)
#  dely_pin_code         :string(45)
#  dely_website          :string(255)
#  dely_contact_person   :string(100)
#  dely_designation      :string(100)
#  dely_phone            :string(50)
#  dely_fax              :string(50)
#  dely_mobile_no        :string(100)
#  dely_email_id         :string(50)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  dely_add_same_cont    :string(45)
#

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end


class Customer < ActiveRecord::Base
   attr_accessible :is_active, :name, :short_name, :code, :group, :opening_balance,
   :dr_cr, :current_balance, :set_as_party, :name_to_print, :comments, :cont_addr_bill_to, :cont_city,
   :cont_district, :cont_state, :cont_country, :cont_pin_code, :cont_website, :cont_contact_person, 
   :cont_designation, :cont_phone, :cont_fax, :cont_mobile_no, :cont_email_id, :tin_no,
   :cst_no, :acct_no, :bank_name, :bank_ifsc, :bank_branch, :license_no, :rate, :currency,
   :central_excise_no, :salesman, :income_tax_no, :use_voucher, :discount_percentage, :credit_period,
   :maximum_credit_limit, :maximum_debit_limit, :stop_if_period_exceed, :stop_if_amount_exceed,
   :segment, :grade, :fleet_order, :dely_addr_ship_to, :dely_city, :dely_district, :dely_state,
   :dely_country, :dely_pin_code, :dely_website, :dely_contact_person, :dely_designation, :dely_phone,
   :dely_fax, :dely_mobile_no, :dely_email_id, :dely_add_same_cont
   
     
   validates :name, :presence => true
   
   validates :name , :uniqueness => true
      
   validates :cont_email_id, :dely_email_id , :allow_blank => true, :uniqueness => true,  :email => true

end
