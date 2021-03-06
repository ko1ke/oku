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

require 'rails_helper'

RSpec.describe Bid, :type => :model do
  it 'auction_id 入力必須' do
    bid = build(:bid, auction_id: nil)
    bid.valid?
    expect(bid.errors[:auction_id]).not_to be_empty
  end

  it 'user_id 入力必須' do
    bid = build(:bid, user_id: nil)
    bid.valid?
    expect(bid.errors[:user_id]).not_to be_empty
  end

  it 'price 入力必須' do
    bid = build(:bid, price: nil)
    bid.valid?
    expect(bid.errors[:price]).not_to be_empty
  end

  it 'price が 0 以上でなければならない' do
    bid = build(:bid, price: -1)
    bid.valid?
    expect(bid.errors[:price]).not_to be_empty
  end

  it 'オークションが開催期間内の入札は有効' do
    auction = create(:auction, open_at: Time.now + 1.day, close_at: Time.now + 3.day)
    bidder = create(:user)
    travel 2.day
    bid = Bid.new(auction_id: auction.id, user_id: bidder.id, price: 1)
    bid.valid?
    expect(bid).to be_valid
  end

  it 'オークション終了日時後の入札はできない' do
    auction = create(:auction, open_at: Time.now + 1.day, close_at: Time.now + 3.day)
    bidder = create(:user)
    travel 3.day
    auction.closed = true
    auction.save
    bid = Bid.new(auction_id: auction.id, user_id: bidder.id, price: 1)
    bid.valid?
    expect(bid.errors[:auction_id]).not_to be_empty
  end

  it 'オークション終了日時後でも、落札処理（入札データの保存）は可能' do
    auction = create(:auction, open_at: Time.now + 1.day, close_at: Time.now + 3.day)
    bidder = create(:user)
    travel 3.day
    bid = Bid.new(auction_id: auction.id, user_id: bidder.id, price: 1, accepted: true)
    expect(bid).to be_valid
  end

  it '開催前のオークションへは入札できない' do
    auction = create(:auction, open_at: Time.now + 1.day, close_at: Time.now + 3.day)
    bidder = create(:user)
    bid = Bid.new(auction_id: auction.id, user_id: bidder.id, price: 1)
    bid.valid?
    expect(bid.errors[:auction_id]).not_to be_empty
  end

  it '現在の最高入札額以下の入札はできない' do
    auction = create(:auction, open_at: Time.now + 1.day, close_at: Time.now + 7.day)
    travel 2.day
    create(:bid, auction_id: auction.id, price: 100)
    bid = build(:bid, auction_id: auction.id, price: 99)
    bid.valid?
    expect(bid.errors[:price]).not_to be_empty
  end

  it '開始価格以下の入札はできない' do
    auction = create(:auction, open_at: Time.now + 1.day, close_at: Time.now + 7.day, first_price: 10)
    travel 2.day
    bid = build(:bid, auction_id: auction.id, price: 9)
    bid.valid?
    expect(bid.errors[:price]).not_to be_empty
  end
end
