require 'rails_helper'

describe Raddar::Message do
  it { is_expected.to belong_to(:sender).class_name('Raddar::User') }
  it { is_expected.to belong_to(:recipient).class_name('Raddar::User') }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:sender_id) }
  it { is_expected.to validate_presence_of(:recipient_id) }
  it { is_expected.to validate_length_of(:content).is_at_most(2_000) }

  it 'ensures that sender/recipient are different' do
    user = create(:user)

    message = build(:message, sender: user, recipient: user)

    expect(message).not_to be_valid
  end

  describe '.distinct_for' do
    it 'includes the last message exchanged with each user' do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)

      m1 = create(:message, sender: user1, recipient: user2)
      m2 = create(:message, sender: user2, recipient: user1)
      m3 = create(:message, sender: user3, recipient: user2)
      m4 = create(:message, sender: user3, recipient: user1)
      m5 = create(:message, sender: user1, recipient: user3)
      m6 = create(:message, sender: user2, recipient: user3)

      expect(described_class.distinct_for(user1)).to eq([m5, m2])
      expect(described_class.distinct_for(user2)).to eq([m6, m2])
      expect(described_class.distinct_for(user3)).to eq([m6, m5])
    end
  end

  describe '.all_between' do
    it 'returns the all messages exchanged between the given users' do
      user1 = create(:user)
      user2 = create(:user)

      m1 = create(:message, sender: user1, recipient: user2)
      m2 = create(:message, sender: user2, recipient: user1)

      expect(described_class.all_between(user1, user2)).to eq([m2, m1])
      expect(described_class.all_between(user2, user1)).to eq([m2, m1])
    end
  end
end
