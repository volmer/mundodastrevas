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
end
