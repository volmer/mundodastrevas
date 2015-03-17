Given(/^I have (\d+) unread notification(s)?$/) do |count, _|
  create_list :notification, count.to_i, user: @user
end

When(/^I open the notifications menu$/) do
  click_on 'notifications-menu'
end

Then(/^I see (\d+) unread notification(s)?$/) do |count, _|
  expect(page).to have_selector('.notification.unread', count: count)
end

Then(/^I see (\d+) read notification(s)?$/) do |count, _|
  expect(page).to have_selector('.notification.read', count: count)
end
