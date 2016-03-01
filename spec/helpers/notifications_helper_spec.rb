require 'rails_helper'

describe NotificationsHelper, type: :helper do
  let(:user) { create(:user) }

  describe '#unread_notifications_count' do
    it 'returns the number of unread notifications for the given user' do
      create_list(:notification, 3, user: user, unread: true)
      create_list(:notification, 7, user: user, unread: false)

      expect(helper.unread_notifications_count(user)).to eq(3)
    end
  end
end
