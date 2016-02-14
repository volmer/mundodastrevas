require 'rails_helper'

describe Message do
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

      create(:message, sender: user1, recipient: user2)
      m2 = create(:message, sender: user2, recipient: user1)
      create(:message, sender: user3, recipient: user2)
      create(:message, sender: user3, recipient: user1)
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

  context 'when it is created' do
    subject! { build(:message, recipient: recipient) }
    let(:recipient) { create(:user) }

    it 'creates a new notification for the recipient' do
      expect { subject.save }
        .to change { subject.recipient.notifications.count }.by(1)
    end

    it 'delivers a notification email to the recipient' do
      expect { subject.save }
        .to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(ActionMailer::Base.deliveries.last.to).to match_array(
        [recipient.email])
    end

    context 'the recipient does not want to receive emails for new messages' do
      let(:recipient) do
        create(:user, email_preferences: { new_message: 'false' })
      end

      it 'does not deliver a notification email' do
        expect { subject.save }
          .not_to change { ActionMailer::Base.deliveries.count }
      end
    end
  end
end
