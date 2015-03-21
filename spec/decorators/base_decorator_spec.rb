require 'rails_helper'

describe Notifications::BaseDecorator do
  let(:notification) { build(:new_follower_notification) }

  subject(:presenter) { described_class.new(notification) }

  describe '#redirect_path' do
    subject { presenter.redirect_path }

    it 'raises an error' do
      expect { subject }.to raise_error('Not yet implemented')
    end
  end

  describe '#text' do
    subject { presenter.text }

    it 'raises an error' do
      expect { subject }.to raise_error('Not yet implemented')
    end
  end

  describe '#mailer_subject' do
    subject { presenter.mailer_subject }

    it 'raises an error' do
      expect { subject }.to raise_error('Not yet implemented')
    end
  end

  describe '#mailer_template' do
    subject { presenter.mailer_template }

    it 'returns the notification event' do
      expect(subject).to eq('new_follower')
    end
  end
end
