# == Schema Information
#
# Table name: evaluations
#
#  id           :integer          not null, primary key
#  evaluater_id :integer
#  evaluatee_id :integer
#  comment      :text
#  created_at   :datetime
#  updated_at   :datetime
#  auction_id   :integer
#  point        :integer          default(0)
#

class Evaluation < ActiveRecord::Base
  extend Enumerize
  enumerize :point, in: {bad: -1, good: 1}, scope: true

  belongs_to :auction
  belongs_to :evaluater, class_name: 'User'
  belongs_to :evaluatee, class_name: 'User'

  validates :auction_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :evaluater_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :evaluatee_id, presence: true, numericality: {only_integer: true, greater_than: 0}
end
