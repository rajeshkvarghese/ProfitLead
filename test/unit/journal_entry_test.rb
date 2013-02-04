# == Schema Information
#
# Table name: journal_entries
#
#  id                       :integer          not null, primary key
#  trans_rec_pay_journal_id :integer
#  journal_date             :date
#  account_head             :string(255)
#  other_account_head       :string(255)
#  amount                   :decimal(10, 2)
#  dr_cr                    :string(255)
#  trans_type               :string(255)
#  master_leg               :string(255)
#  description              :text
#  dr_amount                :decimal(10, 2)
#  cr_amount                :decimal(10, 2)
#  generaljournal_id        :string(45)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require 'test_helper'

class JournalEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
