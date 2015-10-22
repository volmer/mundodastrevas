require 'rails_helper'

describe Comment do
  subject { build(:comment) }

  context 'when a record is created' do
    it 'creates an activity' do
      subject

      expect {
        subject.save
      }.to change{
        Activity.count
      }.by(1)

      activity = Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('comments.create')
      expect(activity.privacy).to eq('public')
    end

    it 'properly notifies the post watchers' do
      expect(subject.post).to receive(:notify_watchers).with(
        subject, 'new_comment', subject.user
      )

      subject.save
    end
  end

  describe '#to_s' do
    it 'describes the author' do
      author = subject.user.name

      expect(subject.to_s).to eq("o comentário de #{author}")
    end
  end
end
