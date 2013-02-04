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

class Accountgroup < ActiveRecord::Base
  attr_accessible :book_type, :group_name, :parent_group, :schedule_no  
  
  validates :book_type, :group_name, :presence => true
  
  validates :group_name , :uniqueness => true
  
end
