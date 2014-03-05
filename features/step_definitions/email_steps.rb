Then(/^I receive an email titled "(.*?)"$/) do |subject|
  expect(ActionMailer::Base.deliveries.last.subject).to eq(subject)
end

Then(/^the email contains "(.*?)"$/) do |content|
  expect(ActionMailer::Base.deliveries.select {|email|
    email.to.include?(@user.email)
  }.first.body).to include(content)
end
