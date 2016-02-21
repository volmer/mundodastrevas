Then(/^the user "(.*?)" can(not)? see my "(.*?)"$/) do |name, negation, field|
  step('I am not signed in')

  pwd = 12_345_678
  create :user, name: name, password: pwd
  step("I sign in with name \"#{name}\" and password \"#{pwd}\"")

  step("I go to #{@user}'s profile page")

  within('#main-container') do
    expect(page).send(negation.blank? ? :to : :not_to, have_content(field))
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

Then(/^user "(.*?)" can(not)? see the link "(.*?)"$/) do |name, negation, link|
  step('I am not signed in')

  password = 12_345_678
  create :user, name: name, password: password
  step("I sign in with name \"#{name}\" and password \"#{password}\"")

  step("I go to #{@user}'s profile page")

  within('.user-profile') do
    expect(page).send(negation.blank? ? :to : :not_to, have_link(link))
  end
end
