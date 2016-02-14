require 'rails_helper'

describe DeviseConcern do
  subject { build :user }

  describe '#active_for_authentication?' do
    # The user must be persisted to fit Devise's requirements
    subject { create(:user) }

    context 'when it is active' do
      before { subject.state = 'active' }

      it 'returns true' do
        expect(subject.active_for_authentication?).to be true
      end
    end

    context 'when it is blocked' do
      before { subject.state = 'blocked' }

      it 'returns false' do
        expect(subject.active_for_authentication?).to be false
      end
    end
  end

  describe '.new_with_session' do
    let(:session) do
      {
        'devise.omniauth_data' => {
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
      }
    end

    let(:params) { {} }

    subject { User.new_with_session(params, session) }

    context 'when name is included in params' do
      let(:params) { { name: 'volmer' } }

      it 'sets the value from params' do
        expect(subject.name).to eq('volmer')
      end
    end

    context 'when name is not included in params' do
      it 'sets the value from session' do
        expect(subject.name).to eq('cindy14')
      end
    end

    context 'when email is included in params' do
      let(:params) { { email: 'volmer@email.com' } }

      it 'sets the value from params' do
        expect(subject.email).to eq('volmer@email.com')
      end
    end

    context 'when email is not included in params' do
      it 'sets the value from session' do
        expect(subject.email).to eq('ops.my.email@example.com')
      end
    end

    context 'when bio is included in params' do
      let(:params) { { bio: 'Pragmatic one.' } }

      it 'sets the value from params' do
        expect(subject.bio).to eq('Pragmatic one.')
      end
    end

    context 'when bio is not included in params' do
      it 'sets the value from session' do
        expect(subject.bio).to eq('My awesome bio.')
      end
    end

    context 'when location is included in params' do
      let(:params) { { location: 'Sao Paulo' } }

      it 'sets the value from params' do
        expect(subject.location).to eq('Sao Paulo')
      end
    end

    context 'when location is not included in params' do
      it 'sets the value from session' do
        expect(subject.location).to eq('The Twins')
      end
    end

    it 'sets the avatar from session' do
      expect(subject.remote_avatar_url).to eq(
        'http://stubbed.com/remote_avatar.jpg')
    end

    context 'with Facebook data' do
      before do
        session['devise.omniauth_data'][:provider] = 'facebook'

        session['devise.omniauth_data'][:extra] = {
          raw_info: {
            birthday: '10/20/1990',
            gender: 'female'
          }
        }
      end

      context 'when birthday is included in params' do
        let(:params) { { birthday: Date.new(1991, 11, 11) } }

        it 'sets the value from params' do
          expect(subject.birthday).to eq(Date.new(1991, 11, 11))
        end
      end

      context 'when birthday is not included in params' do
        it 'sets the value from session' do
          expect(subject.birthday).to eq(Date.new(1990, 10, 20))
        end
      end

      context 'when gender is included in params' do
        let(:params) { { gender: 'male' } }

        it 'sets the value from params' do
          expect(subject.gender).to eq('male')
        end
      end

      context 'when gender is not included in params' do
        it 'sets the value from session' do
          expect(subject.gender).to eq('female')
        end
      end
    end

    context 'when the built user is valid' do
      let(:params) { { password: '12345678' } }

      it 'builds an account to the user' do
        expect(subject.external_accounts.first.user).to eq(subject)
      end
    end
  end
end
