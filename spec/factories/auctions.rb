# == Schema Information
#
# Table name: auctions
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  open_at     :datetime         not null
#  close_at    :datetime         not null
#  first_price :integer          default(0), not null
#  closed      :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string(255)
#  amount      :integer          default(1), not null
#  category_id :integer
#  explanation :text
#  picture     :string(255)
#

FactoryGirl.define do
  factory :auction do
    association :user
    category_id 1
    title 'This is auction title'
    amount 1
    open_at { Time.now + 1.hour }
    close_at { Time.now + 1.day }
    first_price 0
    closed false
  end
end
