Given(/^I am an admin$/) do
  step("\"#{ @user }\" is an admin")
end

Given(/^"(.*?)" is an admin$/) do |user_name|
  user = Raddar::User.find_by(name: user_name)
  role = Raddar::Role.find_or_create_by(name: 'admin')
  user.roles << role
end

When(/^within the admin tabs I click on "(.*?)"$/) do |link|
  within('.admin-tabs') do
    click_on link
  end
end
