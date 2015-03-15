require 'rails_helper'

shared_examples 'a watch setter' do
  context 'when the given user already has a watch relation with it' do
    let(:watch) { create(:watch, watchable: watchable, user: user) }

    before { watch }

    it 'updates the existent watch' do
      subject
      watch.reload
      expect(watch.active).to be false
    end

    it 'does not create a new watch' do
      expect { subject }.to_not change { Raddar::Watch.count }
    end
  end

  context 'when the given user does not have a watch relation with it yet' do
    it 'creates a watch relation with the given params' do
      expect { subject }.to change { watchable.watches.count }.by(1)
      expect(watchable.watches.last.active).to be false
    end
  end
end

describe Raddar::Watchable do
  # Post extends Watchable
  subject(:watchable) { create(:post) }
  let(:user) { create(:user) }
  let(:watch_params) { { active: false } }

  it 'has many watches' do
    expect(subject).to have_many(:watches).class_name('Raddar::Watch').dependent(:destroy)
  end

  describe '#set_watcher' do
    subject { watchable.set_watcher(user, watch_params) }

    it_behaves_like 'a watch setter'

    context 'when the resulting watch has errors' do
      # Watch is not valid without a persisted user
      let(:user) { build(:user) }

      it 'returns false' do
        expect(subject).to be false
      end
    end
  end

  describe '#set_watcher!' do
    subject { watchable.set_watcher!(user, watch_params) }

    it_behaves_like 'a watch setter'

    context 'when the resulting watch has errors' do
      # Watch is not valid without a persisted user
      let(:user) { build(:user) }

      it 'raises an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#watched_by?' do
    subject { watchable.watched_by?(user) }

    context 'when the given user does not have a watch relation with it' do
      it 'returns false' do
        expect(subject).to be false
      end
    end

    context 'when the given user has an active watch relation with it' do
      before { create(:watch, watchable: watchable, user: user, active: true) }

      it 'returns true' do
        expect(subject).to be true
      end
    end

    context 'when the given user has an inactive watch relation with it' do
      before { create(:watch, watchable: watchable, user: user, active: false) }

      it 'returns false' do
        expect(subject).to be false
      end
    end
  end

  describe '#notify_watchers' do
    let(:comment) { create(:comment) }

    subject(:notify_watchers) { watchable.notify_watchers(comment, 'new_comment', user) }

    it 'sends the proper parameters to the job' do
      subject

      job = Raddar::WatchesRetrievalJob.queue_adapter.enqueued_jobs.last

      expect(job[:args]).to eq([watchable, comment, 'new_comment', user])
    end
  end

  describe '#active_watches' do
    it 'returns only watches that has the `active` flag marked as true' do
      inactive_watch = create(:watch, watchable: watchable, active: false)

      expect(watchable.watches).to include(inactive_watch)
      expect(watchable.active_watches).not_to include(inactive_watch)
    end
  end
end
