require 'rails_helper'

describe ForumPost do
  subject(:forum_post) { build(:forum_post) }

  context 'when it is created' do
    it 'touches its topic' do
      expect(subject.topic).to receive(:touch)

      subject.save
    end

    it 'touches its forum' do
      expect(subject.topic.forum).to receive(:touch)

      subject.save
    end

    it 'properly notifies the topic watchers' do
      expect(subject.topic).to receive(:notify_watchers).with(
        subject, 'new_forum_post', subject.user
      )

      subject.save
    end
  end

  context 'when it is updated' do
    before { subject.save }

    it 'does not touch its topic' do
      expect(subject.topic).not_to receive(:touch)

      subject.save
    end

    it 'does not touch its forum' do
      expect(subject.topic.forum).not_to receive(:touch)

      subject.save
    end
  end

  describe '#to_s' do
    it 'describes the author' do
      author = subject.user.name

      expect(subject.to_s).to eq("o post de #{author}")
    end
  end
end
