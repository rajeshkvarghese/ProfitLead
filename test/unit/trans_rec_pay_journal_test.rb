# == Schema Information
#
# Table name: trans_rec_pay_journals
#
#  id                 :integer          not null, primary key
#  journal_date       :date
#  account_head       :string(255)
#  amount             :decimal(10, 2)
#  dr_cr              :string(45)
#  narration          :text
#  cheque_no          :string(255)
#  cheque_date        :date
#  recd_paid_from_to  :string(255)
#  cheque_description :text
#  approve            :string(255)
#  verify             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class TransRecPayJournalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
