require 'rails_helper'

describe Raddar::NotificationsHelper, type: :helper do
  let(:user) { create(:user) }

  describe '#unread_notifications_count' do
    it 'returns the number of unread notifications for the given user' do
      create_list(:notification, 3, user: user, unread: true)
      create_list(:notification, 7, user: user, unread: false)

      expect(helper.unread_notifications_count(user)).to eq(3)
    end
  end

  describe '#last_notifications' do
    it 'returns the last 4 notifications for the given user' do
      create_list(:notification, 6, user: user)

      expect(helper.last_notifications(user).count).to eq(4)
    end
  end

  describe '#link_to_notification' do
    let(:notification) { create(:notification) }

    it 'sets the "href" attribute to the notification path' do
      expect(helper.link_to_notification(notification)).to include("href=\"#{ raddar.notification_path(notification) }\"")
    end

    it 'sets the "id" data attribute to the notification id' do
      expect(helper.link_to_notification(notification)).to include("data-id=\"#{ notification.id }\"")
    end

    context 'with an unread notification' do
      it 'adds the classes "notification" and "unread" to the link' do
        notification.unread = true

        expect(helper.link_to_notification(notification)).to include('class="notification unread"')
      end
    end

    context 'with a read notification' do
      it 'adds the classes "notification" and "read" to the link' do
        notification.unread = false

        expect(helper.link_to_notification(notification)).to include('class="notification read"')
      end
    end
  end
end
