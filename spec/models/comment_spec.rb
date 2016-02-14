require 'rails_helper'

describe Comment do
  subject { build(:comment) }

  context 'when a record is created' do
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
