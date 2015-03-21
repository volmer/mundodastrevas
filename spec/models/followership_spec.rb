require 'rails_helper'

describe Followership do
  subject { build(:followership) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:followable) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
    it { is_expected.to have_many(:activities).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:followable_id) }

    it 'validates uniqueness of user_id scoped to followable' do
      expect(subject.save).to be true

      other = build(:followership)

      expect(other).to be_valid

      other.user = subject.user

      expect(other).to be_valid

      other.followable = subject.followable

      expect(other).not_to be_valid
    end

    it 'is valid with proper values' do
      is_expected.to be_valid
    end

    it 'ensures that a user do not follow himself/herself' do
      user = create(:user)

      followership = build(:followership, user: user, followable: user)

      expect(followership).not_to be_valid
    end
  end

  context 'when a record is created' do
    subject! { build(:followership) }

    it 'creates an activity' do
      expect {
        subject.save
      }.to change{
        Activity.count
      }.by(1)

      activity = Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('followerships.create')
      expect(activity.privacy).to eq('public')
    end
  end
end
