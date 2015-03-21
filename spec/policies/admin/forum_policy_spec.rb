require 'rails_helper'

describe Admin::ForumPolicy do
  let(:user) { User.new }
  subject { described_class.new(user, nil) }

  describe '#index?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.index?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.index?).to be false
      end
    end
  end
end
