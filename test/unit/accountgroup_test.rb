# == Schema Information
#
# Table name: accountgroups
#
#  id           :integer          not null, primary key
#  group_name   :string(255)
#  parent_group :string(255)      not null
#  book_type    :string(255)
#  schedule_no  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class AccountgroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
