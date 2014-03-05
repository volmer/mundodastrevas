require 'spec_helper'

describe RankNotificationWorker do
  subject(:worker) { described_class.new }
  let(:user) { create(:user) }
  let(:rank) { create(:rank) }

  describe '#perform' do
    subject { worker.perform(user.id, rank.id) }

    it 'creates notifications to the watcher' do
      subject

      expect(Raddar::Notification.find_by(user: user)).to be_present
    end

    it 'sends an email to the user' do
      expect {
        subject
      }.to change {
        ActionMailer::Base.deliveries.count
      }
    end

    describe 'the notification sent' do
      it 'has the new_rank event' do
        expect(subject.event).to eq('new_rank')
      end

      it 'has the given rank as the notifiable' do
        expect(subject.notifiable).to eq(rank)
      end
    end

    context 'a notification with the same attributes has already been sent' do
      before { create(:notification, notifiable: rank, user: user, event: 'new_rank') }

      it 'does not creates a new one' do
        expect {
          subject
        }.not_to change {
          Raddar::Notification.count
        }
      end

      it 'does not send a new email' do
        expect {
          subject
        }.not_to change {
          ActionMailer::Base.deliveries.count
        }
      end
    end
  end
end
