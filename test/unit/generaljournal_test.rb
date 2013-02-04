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

require 'test_helper'

class GeneraljournalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
