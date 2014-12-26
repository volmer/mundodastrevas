require 'rails_helper'

describe CommentCompletion do
  subject(:completion) { described_class.new(comment) }
  let(:comment) { build(:comment) }

  describe '#create' do
    subject { completion.create(watch_params) }
    let(:watch_params) { { active: true } }

    it 'saves the comment' do
      expect {
        subject
      }.to change { comment.persisted? }.from(false).to(true)
    end

    it 'properly notifies the post watchers' do
      expect(comment.post).to receive(:notify_watchers).with(comment, 'new_comment', comment.user)

      subject
    end

    it 'sets the comment user as a watcher of the post' do
      expect {
        subject
      }.to change {
        comment.post.watches.count
      }.by(1)

      expect(comment.post).to be_watched_by(comment.user)
    end

    context 'with watch_params populated with active false' do
      let(:watch_params) { { active: false } }

      it 'sets the comment user as an inactive watcher of the post' do
        subject

        new_watch = comment.post.watches.last

        expect(new_watch.active).to be false
      end
    end
  end
end
