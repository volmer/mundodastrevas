require 'rails_helper'

describe ForumPost do
  subject(:forum_post) { build(:forum_post) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_length_of(:content).is_at_most(6_000) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to have_many(:reviews).class_name('Review').dependent(:destroy) }
  it { is_expected.to have_many(:notifications).class_name('Notification').dependent(:destroy) }
  it { is_expected.to have_one(:activity).class_name('Activity').dependent(:destroy) }

  context 'when it is created' do
    it 'touches its topic' do
      expect(subject.topic).to receive(:touch)

      subject.save
    end

    it 'touches its forum' do
      expect(subject.topic.forum).to receive(:touch)

      subject.save
    end

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
      expect(activity.key).to eq('forum_posts.create')
      expect(activity.privacy).to eq('public')
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
