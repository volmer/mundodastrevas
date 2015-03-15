require 'rails_helper'

describe Raddar::Notifications do
  describe '.decorators_mapping' do
    subject { described_class.decorators_mapping }

    it 'includes decorator for :new_follower' do
      expect(subject[:new_follower]).to eq('Raddar::Notifications::NewFollowerDecorator')
    end

    it 'includes decorator for :new_message' do
      expect(subject[:new_message]).to eq('Raddar::Notifications::NewMessageDecorator')
    end
  end

  describe '.decorator_for' do
    it 'returns the proper decorator instance for the given notification' do
      new_follower = build(:new_follower_notification)
      new_message = build(:new_message_notification)

      expect(described_class.decorator_for(new_follower)).to be_a(Raddar::Notifications::NewFollowerDecorator)
      expect(described_class.decorator_for(new_message)).to be_a(Raddar::Notifications::NewMessageDecorator)
    end
  end
end
