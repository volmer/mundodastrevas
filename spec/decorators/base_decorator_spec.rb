require 'rails_helper'

describe Notifications::BaseDecorator, type: :decorator do
  let(:notification) { build(:new_follower_notification) }
  let(:presenter) { described_class.new(notification) }

  describe '#redirect_path' do
    it 'raises an error' do
      expect { presenter.redirect_path }.to raise_error('Not yet implemented')
    end
  end

  describe '#text' do
    it 'raises an error' do
      expect { presenter.text }.to raise_error('Not yet implemented')
    end
  end

  describe '#mailer_subject' do
    it 'raises an error' do
      expect { presenter.mailer_subject }.to raise_error('Not yet implemented')
    end
  end

  describe '#mailer_template' do
    it 'returns the notification event' do
      expect(presenter.mailer_template).to eq('new_follower')
    end
  end
end
