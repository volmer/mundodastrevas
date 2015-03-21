Given(/^I've unchecked "(.*?)" in my email preferences$/) do |field|
  step('I go to the edit user email preferences page')
  step("I uncheck \"#{ field }\"")
  step('I click on "Salvar"')
end

Then(/^I receive an email titled "(.*?)"$/) do |subject|
  expect(ActionMailer::Base.deliveries.last.subject).to eq(subject)
end

Then(/^the email I've received contains "(.*?)"$/) do |content|
  expect(ActionMailer::Base.deliveries.select { |email|
    email.to.include?(@user.email)
  }.first.body).to include(content)
end

Then(/^the email contains "(.*?)"$/) do |content|
  expect(ActionMailer::Base.deliveries.last.body).to include(content)
end

Then(/^I don't receive an email titled "(.*?)"$/) do |subject|
  if ActionMailer::Base.deliveries.present?
    expect(ActionMailer::Base.deliveries.last.subject).not_to eq(subject)
  end
end

Then(/^an email is sent to "(.*?)"$/) do |email|
  expect(ActionMailer::Base.deliveries.last.to).to eq([email])
end

Then(/^I don't receive any emails$/) do
  expect(ActionMailer::Base.deliveries.inject(false) {|result, email|
    result || email.to.include?(@user.email)
  }).to be false
end
