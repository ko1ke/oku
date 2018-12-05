# == Schema Information
#
# Table name: bids
#
#  id         :integer          not null, primary key
#  auction_id :integer          not null
#  user_id    :integer          not null
#  price      :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  accepted   :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :bid do
    association :auction
    association :user
    price [*1..10000].sample
  end
end
