require 'rails_helper'

describe OmniauthCompletion do
  context 'when provider is Facebook' do
    let(:auth_data) do
      {
        provider: 'facebook',
        uid: '123',
        info: {
          email: 'ops.my.email@example.com',
          name: 'Cindy Bragança Sparkles da Silva',
          description: 'My awesome bio.',
          image: 'https://stubbed.com/remote_avatar.jpg',
          urls: { Facebook: 'https://facebook.com/my_profile' },
          location: 'The Twins',
          verified: true
        },
        credentials: { token: 'abcd', expires_at: 1.day.to_i, expires: true },
        extra: { raw_info: { birthday: '10/20/1990', gender: 'female' } }
      }
    end

    before do
      stub_request(:any, /stubbed.com/).to_return(status: 200, body: File.open(
        Rails.root.to_s + '/spec/fixtures/image.jpg'))
    end

    describe '.complete' do
      subject(:complete) { described_class.complete(auth_data, current_user) }

      shared_examples_for 'merge user with the Facebook data' do
        it 'merges description' do
          expect(complete.bio).to eq('My awesome bio.')
        end

        it 'merges location' do
          expect(complete.location).to eq('The Twins')
        end

        it 'merges image' do
          expect(complete.avatar.filename).to eq('remote_avatar.jpg')
        end

        it 'merges birthday' do
          expect(complete.birthday).to eq(Date.new(1990, 10, 20))
        end

        it 'merges gender' do
          expect(complete.gender).to eq('female')
        end
      end

      shared_examples_for 'the external account' do
        context 'the external account' do
          before do
            complete
            external_account.reload
          end

          it 'has the uid' do
            expect(external_account.uid).to eq('123')
          end

          it 'has the provider' do
            expect(external_account.provider).to eq('facebook')
          end

          it 'has the auth token' do
            expect(external_account.token).to eq('abcd')
          end

          it 'has the email' do
            expect(external_account.email).to eq('ops.my.email@example.com')
          end

          it 'has the verified flag' do
            expect(external_account.verified).to be true
          end

          it 'has the url to the external user page' do
            expect(external_account.url).to eq(
              'https://facebook.com/my_profile')
          end
        end
      end

      shared_examples_for 'the created external account' do
        describe 'the created external account' do
          let(:external_account) { complete.external_accounts.last }

          include_examples 'the external account'
        end
      end

      context 'with no current user' do
        let(:current_user) { nil }

        context 'when there is a saved external account for the given data' do
          let!(:external_account) do
            create(:external_account, provider: 'facebook', uid: '123')
          end

          it 'returns its user updated with the auth data' do
            expect(complete).to eq(external_account.user)
          end

          include_examples 'merge user with the Facebook data'

          it 'saves all changes' do
            expect(complete).not_to be_changed
          end

          include_examples 'the external account'
        end

        context 'when there is not an existing external account' do
          context 'when there is an user signed up with the given email' do
            let!(:user) { create(:user, email: 'ops.my.email@example.com') }

            it 'creates an external account for the email owner' do
              expect { subject }
                .to change { user.external_accounts.count }.by(1)
            end

            include_examples 'the created external account'

            include_examples 'merge user with the Facebook data'

            it 'returns the email owner' do
              expect(subject).to eq(user)
            end

            it 'saves all changes' do
              expect(subject).not_to be_changed
            end
          end

          context 'when there is not an user signed up with the given email' do
            it 'sets a name based on the data name' do
              expect(subject.name).to eq('cindy-braganca-s')
            end

            it 'merges email' do
              expect(subject.email).to eq('ops.my.email@example.com')
            end

            include_examples 'merge user with the Facebook data'

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
      end

      context 'with a current user' do
        let(:current_user) { create(:user) }

        context 'when there is a saved external account for the given data' do
          let!(:external_account) do
            create(:external_account, provider: 'facebook', uid: '123')
          end

          context 'when the external account belongs to the current user' do
            before { external_account.update!(user: current_user) }

            include_examples 'merge user with the Facebook data'

            it 'returns the current user' do
              expect(subject).to eq(current_user)
            end

            it 'saves all changes' do
              expect(subject).not_to be_changed
            end

            include_examples 'the external account'
          end

          context 'when the owner of the account is not the current user' do
            it 'raises an error' do
              expect { subject }.to raise_error(
                OmniauthCompletion::ThirdPartyAccountError)
            end
          end
        end

        context 'when there is not a saved external account for the data' do
          it 'creates an external account for the current user' do
            expect { subject }
              .to change { current_user.external_accounts.count }.by(1)
          end

          include_examples 'the created external account'

          include_examples 'merge user with the Facebook data'

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
        it 'sets a valid name based on the data name' do
          expect(user.name).to eq('cindy-braganca-s')
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

      it 'sets the avatar URL from auth data in its large variant' do
        expect(user.remote_avatar_url).to eq(
          'https://stubbed.com/remote_avatar.jpg?type=large')
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

    describe '.build_account' do
      let(:user) { create(:user) }
      subject { described_class.build_account(auth_data, user) }

      it 'returns an account populated with the given auth data' do
        expect(subject.user).to eq(user)
        expect(subject.provider).to eq('facebook')
        expect(subject.token).to eq('abcd')
        expect(subject.verified).to be true
        expect(subject.uid).to eq('123')
        expect(subject.email).to eq('ops.my.email@example.com')
        expect(subject.url).to eq('https://facebook.com/my_profile')
      end
    end
  end
end
