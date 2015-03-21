require 'rails_helper'

describe ExternalAccount do
  subject { build(:external_account) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:activity).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:provider) }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
    it { is_expected.to validate_uniqueness_of(:token).scoped_to(:provider) }
    it { is_expected.to validate_uniqueness_of(:url).scoped_to(:provider) }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_presence_of(:user) }

    it 'validates uniqueness of user_id scoped to provider' do
      expect(subject.save).to be true

      other = build(:external_account, provider: 'bookface')

      expect(other).to be_valid

      other.user = subject.user

      expect(other).to be_valid

      other.provider = subject.provider

      expect(other).not_to be_valid
    end
  end

  context 'when a record is created' do
    subject! { build(:external_account) }

    it 'creates an activity' do
      expect {
        subject.save!
      }.to change{
        Activity.count
      }.by(1)

      activity = Activity.last

      expect(activity.user).to eq(subject.user)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('external_accounts.create')
      expect(activity.privacy).to eq('public')
    end

    context 'when external accounts are private' do
      before do
        subject.user.privacy = { subject.provider => 'only_me' }
        subject.user.save!
      end

      it 'creates a private activity' do
        expect {
          subject.save!
        }.to change{
          Activity.count
        }.by(1)

        activity = Activity.last

        expect(activity.privacy).to eq('only_me')
      end
    end
  end
end
