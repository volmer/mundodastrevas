Then(/^I see "(.*)" in the page$/) do |content|
  expect(page).to have_content(content)
end
