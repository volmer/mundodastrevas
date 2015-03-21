Given(/^I am an admin$/) do
  step("\"#{ @user }\" is an admin")
end

Given(/^"(.*?)" is an admin$/) do |user_name|
  user = User.find_by(name: user_name)
  role = Role.find_or_create_by(name: 'admin')
  user.roles << role
end

Given(/^there are (\d+) users$/) do |count|
  create_list :user, count.to_i
end

When(/^within the admin tabs I click on "(.*?)"$/) do |link|
  within('.admin-tabs') do
    click_on link
  end
end

Then(/^I see (\d+) users$/) do |count|
  expect(page).to have_selector('.user', count: count)
end