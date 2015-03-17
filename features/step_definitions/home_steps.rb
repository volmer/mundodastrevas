Given(/^the site calls "(.*)"$/) do |name|
  Raddar.app_name = name
end

Then(/^I see "(.*)" in the page$/) do |content|
  expect(page).to have_content(content)
end
