# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  code       :integer
#

FactoryGirl.define do
  factory :category do
    code [*1000..9999].sample
    name 'パソコン・周辺機器'
  end
end
