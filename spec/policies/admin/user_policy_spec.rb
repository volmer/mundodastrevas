require 'rails_helper'

describe Admin::UserPolicy do
  subject { described_class.new(user, nil) }

  describe '#index?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.index?).to be true
      end
    end

    context 'when user is not an admin' do
      let(:user) { User.new }

      it 'returns false' do
        expect(subject.index?).to be false
      end
    end
  end

  describe '#show?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.show?).to be true
      end
    end

    context 'when user is not an admin' do
      let(:user) { User.new }

      it 'returns false' do
        expect(subject.show?).to be false
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
      let(:user) { User.new }

      it 'returns false' do
        expect(subject.update?).to be false
      end
    end
  end
end
