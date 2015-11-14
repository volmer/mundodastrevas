require 'rails_helper'

describe WatchesRetrievalJob, type: :job do
  let(:job) { described_class.new }

  describe '#perform' do
    let!(:watchable) { create(:post) }
    let!(:notifiable) { create(:comment) }

    before do
      create_list(:watch, 3, watchable: watchable)
      create_list(:watch, 2, watchable: watchable, active: false)
    end

    it 'enqueues a notification delivery job for each active watcher' do
      expect {
        job.perform(watchable, notifiable, 'new_comment')
      }.to have_enqueued_job(NotificationDeliveryJob).exactly(4).times
    end

    context 'with an user to skip' do
      let(:user_to_skip) { create(:user) }

      before { create(:watch, watchable: watchable, user: user_to_skip) }

      it 'does not enqueue a job to the user' do
        expect {
          job.perform(watchable, notifiable, 'new_comment', user_to_skip)
        }.not_to have_enqueued_job(NotificationDeliveryJob)
      end

      it 'enqueues jobs to other watchers as usual' do
        expect {
          job.perform(watchable, notifiable, 'new_comment', user_to_skip)
        }.to have_enqueued_job(NotificationDeliveryJob).exactly(4).times
      end
    end
  end
end
