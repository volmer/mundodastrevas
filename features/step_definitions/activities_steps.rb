Then /^I see an activity called "(.*?)"$/ do |content|
  expect(page).to have_content(content)
end
