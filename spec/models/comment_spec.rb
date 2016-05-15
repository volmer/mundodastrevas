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
    it 'describes the author and post' do
      expect(subject.to_s).to eq(
        "Comentário de #{subject.user} em #{subject.post}"
      )
    end
  end
end
