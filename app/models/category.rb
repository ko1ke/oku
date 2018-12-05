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

class Category < ActiveRecord::Base
  has_many :auctions

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
end
