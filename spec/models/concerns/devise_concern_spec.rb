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
      { 'devise.omniauth_data' => { omniauth_data: {} } }
    end

    let(:params) { {} }

    subject { User.new_with_session(params, session) }

    before do
      allow(OmniauthCompletion).to receive(:populate).with(
        kind_of(User), omniauth_data: {}
      ) { |u, _| u.name = 'touched' }
      allow(OmniauthCompletion).to receive(:build_account).with(
        { omniauth_data: {} }, kind_of(User)
      ).and_return(account)
    end

    let(:account) { build(:external_account) }

    it 'builds an user based on the omniauth data from session' do
      expect(subject.name).to eq('touched')
    end

    context 'when the built user is valid' do
      let(:params) { { password: '12345678' } }

      it 'builds an account for the user' do
        expect(subject.external_accounts.first).to eq(account)
      end
    end
  end
end
