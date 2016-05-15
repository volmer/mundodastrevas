Given(/^I am not signed in$/) do
  unless page.driver.try(:submit, :delete, destroy_user_session_path, {})
    step('I go to the root page')

    unless find('.navbar').has_content?('Entrar')
      find('.user-menu').click
      click_link 'Sair'
    end
  end
end

Given(/^I am signed in$/) do
  step "I am signed in as \"#{@user.presence || 'someone'}\""
  step 'I do not see the link "Entrar"'
end

Given(/^I am signed in as "(.*?)"$/) do |name|
  password = '12345678'

  if @user.blank? || (@user.name != name)
    @user =
      User.find_by(name: name) || create(:user, name: name, password: password)
  end

  step "I sign in with email \"#{@user.email}\" and password \"#{password}\""
end

Given(/^there are users signed up with the following data:$/) do |table|
  table.hashes.each do |line|
    create :user, line
  end
end

Given(/^there is an user signed up with the following data:$/) do |table|
  step 'there are users signed up with the following data:', table
end

Given(/^I am signed up with the following data:$/) do |table|
  @user = create :user, table.hashes.first
end

Given(/^my email address is "(.*?)"$/) do |email|
  @user.email = email
  @user.skip_confirmation_notification!
  @user.save!
  @user.confirm
end

Given(/^(.*?) has an unconfirmed email "(.*?)"$/) do |user_name, email|
  user = User.find_by(name: user_name)
  user.email = email
  user.skip_confirmation_notification!
  user.save!
end

Given(/^there is an user called "(.*?)"$/) do |name|
  create :user, name: name
end

Given(/^"(.*?)" is blocked$/) do |user_name|
  user = User.find_by(name: user_name)

  user.state = 'blocked'

  user.save!
end

Given('I am blocked') do
  step("\"#{@user}\" is blocked")
end

When(/^I sign in with email "(.*?)" and password "(.*?)"$/) do |email, password|
  step 'I am not signed in'
  step 'I go to the new user session page'
  step "I fill in \"Email\" with \"#{email}\""
  step "I fill in \"Senha\" with \"#{password}\""
  step 'I press "Entrar"'
end

When 'I open my user menu' do
  within '.navbar' do
    click_link @user.name
  end
end

When(/^I go to (.*?)'s profile page$/) do |user_name|
  user = User.find_by(name: user_name)
  visit user_path(user)
end

When(/^I go to my profile page$/) do
  find('.user-menu').click
  click_link 'Perfil'
end

When(/^I confirm my registration$/) do
  user = User.last
  user.confirm
  user.save!
end

Then(/^I see the image "(.*?)" as my avatar$/) do |file_name|
  expect(page).to have_selector(
    :xpath, "//img[contains(@src, '#{file_name}')]", visible: true
  )
end

Then(/^I am successfully signed in as "(.*?)"$/) do |name|
  expect(find('.navbar')).to have_link(name)
end

Then(/^my password is now "(.*?)"$/) do |password|
  @user.reload
  expect(@user.valid_password?(password)).to be true
end

Then(/^I am redirected to my user page$/) do
  @user.reload
  expect(current_path).to eq user_path(@user)
end

Then(/^I see the field "(.*?)" with the value "(.*?)"$/) do |field, value|
  expect(page).to have_selector('dt', text: field)
  expect(page).to have_selector('dd', text: value)
end

Then(/^I am redirected to (.*?)'s profile page$/) do |user_name|
  user = User.find_by(name: user_name)

  expect(current_path).to eq user_path(user)
end

Then(/^I am no longer signed in$/) do
  step('I see the link "Entrar"')
end

Then(/^within my profile I do not see the link "(.*?)"$/) do |link|
  within('.user-profile') do
    expect(page).not_to have_link(link)
  end
end
