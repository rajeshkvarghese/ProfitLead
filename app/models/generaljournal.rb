# == Schema Information
#
# Table name: generaljournals
#
#  id           :integer          not null, primary key
#  journal_date :date
#  job          :string(255)
#  dr_total     :decimal(10, 2)
#  cr_total     :decimal(10, 2)
#  amount       :decimal(10, 2)
#  narration    :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Generaljournal < ActiveRecord::Base
  
  attr_accessible :cr_total, :dr_total, :job, :journal_date, :narration, :amount
  
  has_many :journal_entries, :dependent => :destroy
  
  #validate  :dr_cr_total
  
  
  
  accepts_nested_attributes_for :journal_entries, :reject_if => lambda { |a| a[:account_head].blank? or  a[:amount].blank? or  a[:dr_cr].blank?  }, :allow_destroy => true
  attr_accessible :journal_entries_attributes
  
  
  
   def dr_cr_total
    if :dr_total != :cr_total then
     # record.errors[attribute] << (options[:message] || "is not an email")
      errors.add :dr_total, "Debit and Credit Totals does not match"
      errors.add :cr_total,"Debit and Credit Totals does not match"
    end
  end
  
  
  
  
  
 
end
