require 'rails_helper'

shared_examples_for 'merge user with auth data' do
  it 'merges description' do
    expect(subject.bio).to eq('My awesome bio.')
  end

  it 'merges location' do
    expect(subject.location).to eq('The Twins')
  end

  it 'merges image' do
    expect(subject.avatar.filename).to eq('remote_avatar.jpg')
  end

  context 'when the provider is Facebook' do
    before do
      auth_data[:provider] = 'facebook'

      auth_data[:info][:urls] = {
        Facebook: 'http://facebook.com/cindy14'
      }

      auth_data[:extra] = {
        raw_info: {
          birthday: '10/20/1990',
          gender: 'female'
        }
      }
    end

    it 'merges birthday' do
      expect(subject.birthday).to eq(Date.new(1990, 10, 20))
    end

    it 'merges gender' do
      expect(subject.gender).to eq('female')
    end
  end
end

shared_examples_for 'the created external account' do
  describe 'the created external account' do
    subject { complete.external_accounts.last }

    it 'has the uid' do
      expect(subject.uid).to eq('123')
    end

    it 'has the nickname' do
      expect(subject.name).to eq('cindy14')
    end

    it 'has the provider' do
      expect(subject.provider).to eq('bookface')
    end

    it 'has the auth token' do
      expect(subject.token).to eq('abcd')
    end

    it 'has the secret' do
      expect(subject.secret).to eq('wxyz')
    end

    it 'has the email' do
      expect(subject.email).to eq('ops.my.email@example.com')
    end

    it 'has the verified flag' do
      expect(subject.verified).to be true
    end

    it 'has the url to the external user page' do
      expect(subject.url).to eq('http://bookface.com/cindy14')
    end
  end
end

describe OmniauthCompletion do
  let(:auth_data) do
    {
      provider: 'bookface',
      uid: '123',

      credentials: {
        token: 'abcd',
        secret: 'wxyz'
      },

      info: {
        nickname: 'cindy14',
        verified: true,
        description: 'My awesome bio.',
        location: 'The Twins',
        urls: {
          Bookface: 'http://bookface.com/cindy14'
        },
        image: 'http://stubbed.com/remote_avatar.jpg',
        email: 'ops.my.email@example.com'
      }
    }
  end

  describe '.complete' do
    subject(:complete) { described_class.complete(auth_data, current_user) }

    before do
      stub_request(:any, /stubbed.com/)
        .to_return(
          status: 200,
          body: File.open(Rails.root.to_s + '/spec/fixtures/image.jpg')
        )
    end

    context 'with no current user' do
      let(:current_user) { nil }

      context 'when there is a saved external account for the given data' do
        let!(:existing_account) do
          create(:external_account, provider: 'bookface', uid: '123')
        end

        it 'returns its user' do
          expect(subject).to eq(existing_account.user)
        end
      end

      context 'when there is not a saved external account for the given data' do
        context 'when the given auth data includes an email' do
          context 'when there is an user signed up with the given email' do
            let!(:user) { create(:user, email: 'ops.my.email@example.com') }

            it 'creates an external account for the email owner' do
              expect { subject }
                .to change { user.external_accounts.count }.by(1)
            end

            include_examples 'the created external account'

            include_examples 'merge user with auth data'

            it 'returns the email owner' do
              expect(subject).to eq(user)
            end

            it 'saves all changes' do
              expect(subject).not_to be_changed
            end
          end

          context 'when there is not an user signed up with the given email' do
            it 'merges nickname' do
              expect(subject.name).to eq('cindy14')
            end

            it 'merges email' do
              expect(subject.email).to eq('ops.my.email@example.com')
            end

            include_examples 'merge user with auth data'

            it 'returns a newly created user' do
              expect(subject).to be_persisted
            end

            it 'confirms the new user' do
              expect(subject).to be_confirmed
            end

            it 'saves all changes' do
              expect(subject).not_to be_changed
            end

            include_examples 'the created external account'
          end
        end

        context 'when the given auth data does not include an email' do
          before { auth_data[:info][:email] = nil }

          it 'merges nickname' do
            expect(subject.name).to eq('cindy14')
          end

          include_examples 'merge user with auth data'

          it 'returns a new user' do
            expect(subject).not_to be_persisted
          end

          it 'has one error on Email' do
            subject.valid?

            expect(subject.errors[:email].size).to eq(1)
          end
        end
      end
    end

    context 'with a current user' do
      let(:current_user) { create(:user) }

      context 'when there is a saved external account for the given data' do
        context 'when the owner of the external account is the current user' do
          before do
            create(
              :external_account,
              provider: 'bookface',
              uid: '123',
              user: current_user)
          end

          include_examples 'merge user with auth data'

          it 'returns the current user' do
            expect(subject).to eq(current_user)
          end

          it 'saves all changes' do
            expect(subject).not_to be_changed
          end
        end

        context 'when the owner of the account is not the current user' do
          before { create(:external_account, provider: 'bookface', uid: '123') }

          it 'raises an error' do
            expect { subject }.to raise_error
          end
        end
      end

      context 'when there is not a saved external account for the given data' do
        it 'creates an external account for the current user' do
          expect { subject }
            .to change { current_user.external_accounts.count }.by(1)
        end

        include_examples 'the created external account'

        include_examples 'merge user with auth data'

        it 'returns the current user' do
          expect(subject).to eq(current_user)
        end

        it 'saves all changes' do
          expect(subject).not_to be_changed
        end
      end
    end
  end

  describe '.populate' do
    let(:user) { User.new }

    before { described_class.populate(user, auth_data) }

    context 'when name is present in user' do
      let(:user) { User.new(name: 'volmer') }

      it 'keeps the value' do
        expect(user.name).to eq('volmer')
      end
    end

    context 'when name is not present in user' do
      it 'sets the value from auth data' do
        expect(user.name).to eq('cindy14')
      end
    end

    context 'when email is present in user' do
      let(:user) { User.new(email: 'volmer@email.com') }

      it 'keeps the value' do
        expect(user.email).to eq('volmer@email.com')
      end
    end

    context 'when email is not present in user' do
      it 'sets the value from auth data' do
        expect(user.email).to eq('ops.my.email@example.com')
      end
    end

    context 'when bio is present in user' do
      let(:user) { User.new(bio: 'Pragmatic one.') }

      it 'keeps the value' do
        expect(user.bio).to eq('Pragmatic one.')
      end
    end

    context 'when bio is not present in user' do
      it 'sets the value from auth data' do
        expect(user.bio).to eq('My awesome bio.')
      end
    end

    context 'when location is present in user' do
      let(:user) { User.new(location: 'Sao Paulo') }

      it 'keeps the value' do
        expect(user.location).to eq('Sao Paulo')
      end
    end

    context 'when location is not present in user' do
      it 'sets the value from auth data' do
        expect(user.location).to eq('The Twins')
      end
    end

    it 'sets the avatar from session' do
      expect(user.remote_avatar_url).to eq('http://stubbed.com/remote_avatar.jpg')
    end

    context 'with Facebook data' do
      let(:auth_data) do
        super().merge(
          provider: 'facebook',
          extra: {
            raw_info: { birthday: '10/20/1990', gender: 'female' }
          }
        )
      end

      context 'when birthday is present in user' do
        let(:user) { User.new(birthday: Date.new(1991, 11, 11)) }

        it 'keeps the value' do
          expect(user.birthday).to eq(Date.new(1991, 11, 11))
        end
      end

      context 'when birthday is not present in user' do
        it 'sets the value from auth data' do
          expect(user.birthday).to eq(Date.new(1990, 10, 20))
        end
      end

      context 'when gender is present in user' do
        let(:user) { User.new(gender: 'male') }

        it 'keeps the value' do
          expect(user.gender).to eq('male')
        end
      end

      context 'when gender is not present in user' do
        it 'sets the value from auth data' do
          expect(user.gender).to eq('female')
        end
      end
    end
  end

  describe '.build_account' do
    let(:user) { create(:user) }
    subject { described_class.build_account(auth_data, user) }

    it 'returns an account populated with the given auth data' do
      expect(subject.user).to eq(user)
      expect(subject.provider).to eq('bookface')
      expect(subject.token).to eq('abcd')
      expect(subject.secret).to eq('wxyz')
      expect(subject.verified).to be true
      expect(subject.name).to eq('cindy14')
      expect(subject.uid).to eq('123')
      expect(subject.email).to eq('ops.my.email@example.com')
      expect(subject.url).to eq('http://bookface.com/cindy14')
    end
  end
end
