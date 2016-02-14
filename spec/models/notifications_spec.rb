require 'rails_helper'

describe Notifications do
  describe '.events' do
    it 'is a list of valid events' do
      expect(described_class.events).to eq(
        %w(new_comment new_forum_post new_message new_rank)
      )
    end
  end

  describe '.decorator_for' do
    it 'returns the proper decorator instance for the given notification' do
      new_message = build(:new_message_notification)

      expect(described_class.decorator_for(new_message))
        .to be_a(Notifications::NewMessageDecorator)
    end
  end
end
