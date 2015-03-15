require 'rails_helper'

describe Raddar::User do
  subject { build :user }

  it { is_expected.to be_a(Raddar::Followable) }

  it 'uses devise-encryptable' do
    expect(subject.devise_modules).to include(:encryptable)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(16) }

    it { is_expected.to allow_value('volmer').for(:name) }
    it { is_expected.to allow_value('vol_mer').for(:name) }
    it { is_expected.to allow_value('VOLMER').for(:name) }
    it { is_expected.to allow_value('vol-mer').for(:name) }
    it { is_expected.to allow_value('volmer123').for(:name) }
    it { is_expected.not_to allow_value('volmer!').for(:name) }
    it { is_expected.not_to allow_value('vol mer').for(:name) }

    it { is_expected.to validate_inclusion_of(:state).in_array(['active', 'blocked']) }
    it { is_expected.to validate_presence_of(:state) }

    it { is_expected.to validate_length_of(:bio).is_at_most(500) }
    it { is_expected.to validate_length_of(:location).is_at_most(200) }
    it { is_expected.to validate_inclusion_of(:gender).in_array(['male', 'female']) }
    it { is_expected.to allow_value('').for(:gender) }
    it { is_expected.to allow_value(nil).for(:gender) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:followerships).dependent(:destroy) }
    it { is_expected.to have_and_belong_to_many(:roles) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
    it { is_expected.to have_many(:external_accounts).dependent(:destroy) }
    it { is_expected.to have_many(:sent_messages).class_name('Raddar::Message').dependent(:destroy) }
    it { is_expected.to have_many(:incoming_messages).class_name('Raddar::Message').dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:watches).dependent(:destroy) }
    it { is_expected.to have_many(:activities).dependent(:destroy) }
    it { is_expected.to have_many(:related_activities).class_name('Raddar::Activity').dependent(:destroy) }
    it { is_expected.to have_many(:zines).class_name('Zine').dependent(:destroy) }
    it { is_expected.to have_many(:posts).class_name('Post').dependent(:destroy) }
    it { is_expected.to have_many(:comments).class_name('Comment').dependent(:destroy) }
    it { is_expected.to have_many(:topics).class_name('Topic').dependent(:destroy) }
    it { is_expected.to have_many(:forum_posts).class_name('ForumPost').dependent(:destroy) }
    it { is_expected.to have_many(:levels).dependent(:destroy) }
  end

  describe '#avatar' do
    it 'is an uploader field' do
      expect(subject.avatar).to be_an_instance_of(Raddar::AvatarUploader)
    end
  end

  describe '#privacy' do
    it 'stores a hash of privacy options' do
      subject.privacy = { email: 'public', location: 'only_me' }
      subject.save!
      subject.reload

      expect(subject.privacy).to be_a_kind_of(Hash)
      expect(subject.privacy['email']).to eq 'public'
      expect(subject.privacy['location']).to eq 'only_me'
    end
  end

  describe '.privaciable_fields' do
    it 'contains :email' do
      expect(described_class.privaciable_fields).to include(:email)
    end

    it 'contains :gender' do
      expect(described_class.privaciable_fields).to include(:gender)
    end

    it 'contains :birthday' do
      expect(described_class.privaciable_fields).to include(:birthday)
    end

    it 'contains :location' do
      expect(described_class.privaciable_fields).to include(:location)
    end

    it 'does not contain :name' do
      expect(described_class.privaciable_fields).not_to include(:name)
    end

    it 'does not contain :avatar' do
      expect(described_class.privaciable_fields).not_to include(:avatar)
    end
  end

  describe '#admin?' do
    context 'when it has the admin role' do
      subject { create :admin }

      it 'returns true' do
        expect(subject.admin?).to be true
      end
    end

    context 'when it does not have the admin role' do
      it 'returns false' do
        expect(subject.admin?).to be false
      end
    end
  end

  describe '#email_preferences' do
    it 'stores a hash of email preferences' do
      subject.email_preferences = { new_follower: false }
      subject.save!
      subject.reload

      expect(subject.email_preferences).to be_a_kind_of(Hash)
      expect(subject.email_preferences['new_follower']).to eq 'false'
    end
  end

  describe '.email_preferences_keys' do
    it 'contains new_follower' do
      expect(described_class.email_preferences_keys).to include('new_follower')
    end

    it 'contains new_message' do
      expect(described_class.email_preferences_keys).to include('new_message')
    end
  end

  describe '.find_by_name' do
    it 'retrieves the user with the given name, case insensitive' do
      subject.name = 'Bran'
      subject.save!

      expect(described_class.find_by_name('Bran')).to eq subject
      expect(described_class.find_by_name('bran')).to eq subject
      expect(described_class.find_by_name('BRAN')).to eq subject
    end

    it 'returns nil if nothing is found' do
      expect(
        described_class.find_by_name('unexistent')
      ).to be_nil
    end
  end

  describe '.find_by_name!' do
    it 'retrieves the user with the given name, case insensitive' do
      subject.name = 'Bran'
      subject.save!

      expect(described_class.find_by_name!('Bran')).to eq subject
      expect(described_class.find_by_name!('bran')).to eq subject
      expect(described_class.find_by_name!('BRAN')).to eq subject
    end

    it 'raises an error if nothing is found' do
      expect {
        described_class.find_by_name!('unexistent')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#privacy_keys' do
    it 'returns an array including the privaciable fields' do
      expect(subject.privacy_keys).to include(*described_class.privaciable_fields)
    end

    context 'when the user has an external account' do
      subject(:user) { create(:user) }
      before { create(:external_account, provider: 'github', user: user) }

      it 'includes the provider name for the external account' do
        subject.reload

        expect(subject.privacy_keys).to include('github')
      end
    end
  end

  describe '#to_s' do
    it 'returns the user name' do
      subject.name = 'volmer'

      expect(subject.to_s).to eq('volmer')
    end
  end

  describe '#to_param' do
    it 'returns the user name' do
      subject.name = 'volmer'

      expect(subject.to_param).to eq('volmer')
    end
  end

  describe '#active?' do
    it 'returns true if it is on the active state' do
      subject.state = 'active'

      expect(subject).to be_active
    end

    it 'returns false if it is not on the active state' do
      subject.state = 'not_active'

      expect(subject).not_to be_active
    end
  end

  context 'when a record is created' do
    it 'creates an activity' do
      expect {
        subject.save
      }.to change{
        Raddar::Activity.count
      }.by(1)

      activity = Raddar::Activity.last

      expect(activity.user).to eq(subject)
      expect(activity.subject).to eq(subject)
      expect(activity.key).to eq('users.sign_up')
      expect(activity.privacy).to eq('public')
    end
  end

  context 'when privacy settings are changed' do
    context 'when an external account is set to public' do
      it 'sets the associated activity to public' do
        subject.save!
        create(:external_account, provider: 'twitter', user: subject)
        activity = Raddar::Activity.last
        subject.privacy = { twitter: 'only_me' }
        subject.save!
        activity.reload

        expect(activity.privacy).to eq('only_me')
      end
    end

    context 'when an external account is set to only_me' do
      it 'sets the associated activity to only_me' do
        subject.privacy = { twitter: 'only_me' }
        subject.save!
        create(:external_account, provider: 'twitter', user: subject)
        activity = Raddar::Activity.last
        subject.privacy = { twitter: 'public' }
        subject.save!
        activity.reload

        expect(activity.privacy).to eq('public')
      end
    end
  end

  describe '#rank_in' do
    subject { user.rank_in(universe) }
    let(:user) { create(:user) }

    context 'with a valid universe' do
      let(:universe) { create(:universe) }

      context 'when the user does not have a level in the given universe' do
        context 'when the given universe does not have a rank with value 1' do
          it 'returns nil' do
            expect(subject).to be_nil
          end
        end

        context 'when the given universe have a rank with value 1' do
          let!(:rank) { create(:rank, universe: universe, value: 1) }

          it 'sets the user level in the given universe to 1' do
            expect {
              subject
            }.to change {
              user.levels.count
            }.by(1)

            new_level = user.levels.last

            expect(new_level.universe).to eq(universe)
            expect(new_level.value).to eq(1)
          end

          it 'returns the rank' do
            expect(subject).to eq(rank)
          end
        end
      end

      context 'when the user has a level in the given universe' do
        let!(:level) { create(:level, user: user, universe: universe) }

        context 'when the given universe does not have a rank with the level value' do
          it 'returns nil' do
            expect(subject).to be_nil
          end
        end

        context 'when the given universe have a rank with the same value as the user level' do
          let!(:rank) { create(:rank, universe: universe, value: level.value) }

          it 'returns the rank' do
            expect(subject).to eq(rank)
          end
        end
      end
    end

    context 'with a nil universe' do
      let(:universe) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end