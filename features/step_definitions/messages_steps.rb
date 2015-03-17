Given(/^(.*?) has sent me the message: "(.*?)"$/) do |user, content|
  recipient = @user

  step("I am signed in as \"#{ user }\"")
  visit raddar.user_messages_path(recipient)
  fill_in('message_content', with: content)
  click_on('Enviar')

  step("I am signed in as \"#{ recipient }\"")
end

Given(/^I have exchanged messages with (\d+) users$/) do |count|
  create_list(:message, count.to_i, sender: @user)
end

Then(/^I see (\d+) messages$/) do |count|
  expect(page).to have_selector('.message', count: count)
end
