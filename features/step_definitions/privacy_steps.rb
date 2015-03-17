Then(/^the user "(.*?)" can(not)? see my "(.*?)"$/) do |user_name, negation, field|
  step('I am not signed in')

  password = 12345678
  another_user = create :user, name: user_name, password: password
  step("I sign in with the name \"#{ user_name }\" and the password \"#{ password }\"")

  step("I go to #{ @user }'s profile page")

  within('#main-container') do
    expect(page).send( negation.blank? ? :to : :not_to, have_content(field))
  end
end

Then(/^I can see my "(.*?)"$/) do |field|
  step('I go to my profile page')

  within('#main-container') do
    expect(page).to have_content(field)
  end
end

Then(/^I can see the link "(.*?)" in my profile page$/) do |link|
  step('I go to my profile page')

  expect(page).to have_link(link)
end

Then(/^the user "(.*?)" can(not)? see the link "(.*?)" in my profile page$/) do |user_name, negation, link|
  step('I am not signed in')

  password = 12345678
  another_user = create :user, name: user_name, password: password
  step("I sign in with the name \"#{ user_name }\" and the password \"#{ password }\"")

  step("I go to #{ @user }'s profile page")

  within('.user-profile') do
    expect(page).send( negation.blank? ? :to : :not_to, have_link(link))
  end
end
