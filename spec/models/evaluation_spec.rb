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

require 'rails_helper'

RSpec.describe Evaluation, :type => :model do
  let(:auction) { create(:auction) }
  let(:evaluater) { create(:user) }
  let(:evaluatee) { create(:user) }
  let(:evaluation) { evaluater.evaluations.build(auction_id: auction.id, evaluatee_id: evaluatee.id) }

  subject { evaluation }

  it { should be_valid }
end
