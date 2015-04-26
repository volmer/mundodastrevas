require 'rails_helper'

describe Notifications::NewFollowerDecorator, type: :decorator do
  let(:follower) { create(:user, name: 'volmer') }

  let(:followership) { create(:followership, user: follower) }

  let(:notification) { build(:new_follower_notification, notifiable: followership) }

  subject(:presenter) { described_class.new(notification) }

  describe '#redirect_path' do
    subject { presenter.redirect_path }

    it 'returns the path to the follower page' do
      expect(subject).to eq('/users/volmer')
    end
  end

  describe '#text' do
    subject { presenter.text }

    it 'includes the proper text' do
      expect(subject).to include('volmer está te seguindo')
    end
  end

  describe '#mailer_subject' do
    subject { presenter.mailer_subject }

    it 'returns the proper text' do
      expect(subject).to eq('volmer começou a te seguir!')
    end
  end
end
