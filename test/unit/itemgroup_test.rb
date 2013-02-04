# == Schema Information
#
# Table name: itemgroups
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  code              :string(50)       not null
#  main_group        :string(50)
#  tax               :string(50)
#  discount_per      :decimal(10, 2)
#  description       :string(100)
#  category          :string(50)
#  print_only_sum    :string(50)
#  print_name        :string(100)
#  update_tax_child  :string(50)
#  update_disc_child :string(50)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class ItemgroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
