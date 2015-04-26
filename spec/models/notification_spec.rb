require 'rails_helper'

describe Notification do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:notifiable) }

  it { is_expected.to validate_presence_of(:event) }
  it { is_expected.to validate_presence_of(:notifiable_id) }
  it { is_expected.to validate_presence_of(:user_id) }

  it 'validates inlcusion of events' do
    Notifications.events.each do |event|
      subject.event = event
      subject.valid?

      expect(subject.errors[:event].size).to eq(0)
    end

    subject.event = 'invalid_event'
    subject.valid?

    expect(subject.errors[:event].size).to eq(1)
  end

  describe '#send!' do
    let(:notification) { build(:notification) }

    subject { notification.send! }

    it 'saves it' do
      subject

      expect(notification).to be_persisted
    end

    context 'when user does not want to receive emails regarding the given event' do
      before do
        notification.user.email_preferences = { notification.event => false }
      end

      it 'does not send an email' do
        expect {
          subject
        }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end

    context 'when user want to receive emails regarding the given event' do
      before do
        notification.user.email_preferences = { notification.event => true }
      end

      it 'sends an email' do
        expect {
          subject
        }.to change { ActionMailer::Base.deliveries.count }
      end
    end

    context 'when user did not define preferences about recieving about the given event' do
      it 'sends an email' do
        expect {
          subject
        }.to change { ActionMailer::Base.deliveries.count }
      end
    end
  end
end
