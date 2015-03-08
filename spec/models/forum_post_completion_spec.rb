require 'rails_helper'

describe ForumPostCompletion do
  subject(:completion) { described_class.new(forum_post) }
  let(:forum_post) { build(:forum_post) }

  describe '#create' do
    subject { completion.create(watch_params) }
    let(:watch_params) { { active: true } }

    it 'saves the post' do
      expect {
        subject
      }.to change { forum_post.persisted? }.from(false).to(true)
    end

    it 'properly notifies the topic watchers' do
      expect(forum_post.topic).to receive(:notify_watchers).with(
        forum_post, 'new_forum_post', forum_post.user
      )

      subject
    end

    it 'sets the post user as a watcher of the post topic' do
      expect {
        subject
      }.to change {
        forum_post.topic.watches.count
      }.by(1)

      expect(forum_post.topic).to be_watched_by(forum_post.user)
    end

    context 'with watch_params populated with active false' do
      let(:watch_params) { { active: false } }

      it 'sets the post user as an inactive watcher of the post topic' do
        subject

        new_watch = forum_post.topic.watches.last

        expect(new_watch.active).to be false
      end
    end
  end
end
