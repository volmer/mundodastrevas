require 'rails_helper'

describe Comment do
  subject { build(:comment) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:reviews).class_name('Raddar::Review').dependent(:destroy) }
  it { is_expected.to have_many(:notifications).class_name('Raddar::Notification').dependent(:destroy) }
  it { is_expected.to have_one(:activity).class_name('Raddar::Activity').dependent(:destroy) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to ensure_length_of(:content).is_at_most(6_000) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:post_id) }

  context 'when a record is created' do
    it 'creates an activity' do
      subject

      expect {
        subject.save
      }.to change{
        Raddar::Activity.count
      }.by(1)

      activity = Raddar::Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('comments.create')
      expect(activity.privacy).to eq('public')
    end
  end

  describe '#to_s' do
    it 'describes the author' do
      author = subject.user.name

      expect(subject.to_s).to eq("o comentário de #{author}")
    end
  end
end
