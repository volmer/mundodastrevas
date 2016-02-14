require 'rails_helper'

describe User do
  subject { build :user }

  it 'validates name' do
    subject.name = 'volmaire'
    expect(subject).to be_valid

    subject.name = 'vol_maire'
    expect(subject).to be_valid

    subject.name = 'VOLMAIRE'
    expect(subject).to be_valid

    subject.name = 'vol-maire'
    expect(subject).to be_valid

    subject.name = 'volmaire123'
    expect(subject).to be_valid

    subject.name = 'volmaire!'
    expect(subject).not_to be_valid

    subject.name = 'vol maire'
    expect(subject).not_to be_valid
  end

  describe '#avatar' do
    it 'is an uploader field' do
      expect(subject.avatar).to be_an_instance_of(ImageUploader)
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
      subject.email_preferences = { new_message: false }
      subject.save!
      subject.reload

      expect(subject.email_preferences).to be_a_kind_of(Hash)
      expect(subject.email_preferences['new_message']).to eq 'false'
    end
  end

  describe '.email_preferences_keys' do
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
      expect { described_class.find_by_name!('unexistent') }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#privacy_keys' do
    it 'returns an array of private attributes' do
      expect(subject.privacy_keys).to eq(
        %w(email gender location birthday)
      )
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
            expect { subject }.to change { user.levels.count }.by(1)

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

        context 'when the given universe does not have a rank for level' do
          it 'returns nil' do
            expect(subject).to be_nil
          end
        end

        context 'when universe has a rank for the user level' do
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
