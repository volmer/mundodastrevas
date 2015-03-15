require 'rails_helper'

describe Raddar::UserPolicy do
  subject { described_class.new(user, record) }

  describe '#show?' do
    let(:record) { Raddar::User.new }

    context 'when user is signed in' do
      let(:user) { Raddar::User.new }

      it 'returns true' do
        expect(subject.show?).to be true
      end
    end

    context 'when user is not signed in' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.show?).to be false
      end
    end
  end

  describe '#read_field?' do
    context 'when user is the owner of the field' do
      let(:user) { Raddar::User.new }
      let(:record) { user }

      it 'returns true' do
        expect(subject.read_field?(:my_attr)).to be true
      end
    end

    context 'when user is not the owner of the field' do
      let(:user) { Raddar::User.new }
      let(:record) { Raddar::User.new }

      context 'when the privacy setting for the field is "public"' do
        before { record.privacy = { my_attr: 'public' } }

        it 'returns true' do
          expect(subject.read_field?(:my_attr)).to be true
        end
      end

      context 'when the privacy setting for the field is "only_me"' do
        before { record.privacy = { my_attr: 'only_me' } }

        it 'returns false' do
          expect(subject.read_field?(:my_attr)).to be false
        end
      end

      context 'when there is no privacy setting for the field' do
        before { record.privacy = {} }

        it 'returns true' do
          expect(subject.read_field?(:my_attr)).to be true
        end
      end
    end
  end
end
