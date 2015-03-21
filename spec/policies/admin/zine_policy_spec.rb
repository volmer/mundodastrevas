require 'rails_helper'

describe Admin::ZinePolicy do
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

  describe '#edit?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.edit?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.edit?).to be false
      end
    end
  end

  describe '#update?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.update?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.update?).to be false
      end
    end
  end
end
