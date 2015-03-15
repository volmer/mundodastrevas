require 'rails_helper'

describe Raddar::MessagePolicy do
  subject { described_class.new(user, record) }
  let(:user) { Raddar::User.new }
  let(:record) { Raddar::Message.new }

  describe '#index?' do
    context 'when user is signed in' do
      it 'returns true' do
        expect(subject.index?).to be true
      end
    end

    context 'when user is not signed in' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.index?).to be false
      end
    end
  end

  describe '#create?' do
    context 'when user is signed in' do
      context 'when user is the sender' do
        let(:record) { Raddar::Message.new(sender: user) }

        it 'returns true' do
          expect(subject.create?).to be true
        end
      end

      context 'when user is not the sender' do
        it 'returns false' do
          expect(subject.create?).to be false
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.create?).to be false
      end
    end
  end
end
