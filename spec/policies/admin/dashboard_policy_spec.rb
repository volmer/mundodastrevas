require 'rails_helper'

describe Raddar::Admin::DashboardPolicy do
  subject { described_class.new(user, nil) }

  describe '#index?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.index?).to be true
      end
    end

    context 'when user is not an admin' do
      let(:user) { Raddar::User.new }

      it 'returns false' do
        expect(subject.index?).to be false
      end
    end

    context 'when user is not set' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.index?).to be false
      end
    end
  end
end
