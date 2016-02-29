Given(/^I have (\d+) unread notification(s)?$/) do |count, _|
  create_list :notification, count.to_i, user: @user
end

When(/^I click on the first notification$/) do
  find('.notification', match: :first).click
end

Then(/^I see (\d+) unread notification(s)?$/) do |count, _|
  expect(page).to have_selector('.notification.unread', count: count)
end

Then(/^I see (\d+) read notification(s)?$/) do |count, _|
  expect(page).to have_selector('.notification.read', count: count)
end
