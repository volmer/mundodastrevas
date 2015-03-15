require 'rails_helper'

describe Raddar::WatchesRetrievalJob, type: :job do
  subject(:job) { described_class.new }

  describe '#perform' do
    let(:watchable) { create(:post) }
    let(:notifiable) { create(:comment) }

    subject { job.perform(watchable, notifiable, 'new_comment') }

    before do
      create_list(:watch, 3, watchable: watchable)
      create_list(:watch, 2, watchable: watchable, active: false)
    end

    it 'enqueues a notification delivery job for each active watcher' do
      expect {
        subject
      }.to change(
        Raddar::NotificationDeliveryJob.queue_adapter.enqueued_jobs, :size
      # 3 watchers from the list plus the post author
      ).by(4)
    end

    context 'with an user to skip' do
      let(:user_to_skip) { create(:user) }

      subject { job.perform(watchable, notifiable, 'new_comment', user_to_skip) }

      before { create(:watch, watchable: watchable, user: user_to_skip) }

      it 'does not enqueue a job to the user' do
        expect(
          Raddar::NotificationDeliveryJob
        ).not_to receive(:perform_later).with(user_to_skip, anything, anything)

        subject
      end

      it 'enqueues jobs to other watchers as usual' do
        expect {
          subject
        }.to change(
          Raddar::NotificationDeliveryJob.queue_adapter.enqueued_jobs, :size
        # 3 watchers from the list plus the post author
        ).by(4)
      end
    end
  end
end
