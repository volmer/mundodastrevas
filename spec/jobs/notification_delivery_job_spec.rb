require 'rails_helper'

describe NotificationDeliveryJob, type: :job do
  subject(:job) { described_class.new }
  let(:notifiable) { create(:comment) }
  let(:user) { create(:user) }

  describe '#perform' do
    subject { job.perform(user, notifiable, 'new_comment') }

    it 'creates notifications to the watcher' do
      subject

      expect(Notification.find_by(user: user)).to be_present
    end

    it 'sends an email to the watcher' do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }
    end

    describe 'the notification sent' do
      it 'has the given event' do
        expect(subject.event).to eq('new_comment')
      end

      it 'has the given notifiable' do
        expect(subject.notifiable).to eq(notifiable)
      end
    end

    context 'a notification with the same attributes has already been sent' do
      before do
        create(
          :notification,
          notifiable: notifiable,
          user: user,
          event: 'new_comment')
      end

      it 'does not creates a new one' do
        expect { subject }.not_to change { Notification.count }
      end

      it 'does not send a new email' do
        expect { subject }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end
  end
end
