require 'rails_helper'

describe NotificationPolicy do
  subject { described_class.new(user, record) }
  let(:user) { User.new }
  let(:record) { Notification.new }

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

  describe '#show?' do
    context 'when user owns the notification' do
      let(:record) { Notification.new(user: user) }

      it 'returns true' do
        expect(subject.show?).to be true
      end
    end

    context 'when user does not own the notification' do
      it 'returns false' do
        expect(subject.show?).to be false
      end
    end
  end

  describe '#read?' do
    context 'when user owns the notification' do
      let(:record) { Notification.new(user: user) }

      it 'returns true' do
        expect(subject.read?).to be true
      end
    end

    context 'when user does not own the notification' do
      it 'returns false' do
        expect(subject.read?).to be false
      end
    end
  end
end
