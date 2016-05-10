Given(/^I have (\d+) unread notification(s)?$/) do |count, _|
  create_list :notification, count.to_i, user: @user
end

When(/^I click on the first notification$/) do
  find('.notifications a', match: :first).click
end

Then(/^I see (\d+) notification(s)?$/) do |count, _|
  expect(page).to have_selector('.notifications', count: count)
end

Then(/^I see (\d+) unread notification(s)?$/) do |count, _|
  expect(page).to have_selector('.notifications .unread', count: count)
end

Then(/^I see (\d+) read notification(s)?$/) do |count, _|
  expect(page).to have_selector('.notifications .read', count: count)
end
