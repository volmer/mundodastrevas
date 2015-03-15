require 'rails_helper'

describe Raddar::Notifications::NewMessageDecorator do
  let(:sender) { create(:user, name: 'volmer') }

  let(:message) { create(:message, sender: sender) }

  let(:notification) { build(:new_message_notification, notifiable: message) }

  subject(:presenter) { described_class.new(notification) }

  describe '#redirect_path' do
    subject { presenter.redirect_path }

    it 'returns the path to the sender messages page' do
      expect(subject).to eq('/users/volmer/messages')
    end
  end

  describe '#text' do
    subject { presenter.text }

    it 'includes the proper text' do
      expect(subject).to include('volmer te enviou uma mensagem')
    end
  end

  describe '#mailer_subject' do
    subject { presenter.mailer_subject }

    it 'returns the proper text' do
      expect(subject).to eq('volmer te enviou uma mensagem')
    end
  end

  describe '#mailer_template' do
    subject { presenter.mailer_template }

    it 'returns new_message' do
      expect(subject).to eq('new_message')
    end
  end
end
