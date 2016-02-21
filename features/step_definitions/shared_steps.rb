Given(/^I am on the (.*?) page$/) do |page_name|
  visit path_to(page_name)
end

When(/^I go to the (.*?) page$/) do |page_name|
  visit path_to(page_name)
end

When(/^I access the path "(.*?)"$/) do |path|
  visit path
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I fill in "(.*?)" with the following text:$/) do |field, value|
  fill_in field, with: value
end

When(/^I don't fill in "(.*?)"$/) do |field|
  fill_in field, with: ''
end

When(/^for "(.*?)" I choose "(.*?)"$/) do |_field, value|
  choose(value) unless value.blank?
end

When(/^I click on "(.*?)"$/) do |clickable|
  click_on clickable
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

When(/^I check "(.*?)"$/) do |checkbox|
  check checkbox
end

When(/^from "(.*?)" I select "(.*?)"$/) do |field, option|
  select(option, from: field)
end

When(/^I attach the file "(.*?)" to "(.*?)"$/) do |file, field|
  attach_file(field, Rails.root.to_s + '/features/support/fixtures/' + file)
end

When(/^I uncheck "(.*?)"$/) do |checkbox|
  uncheck(checkbox)
end

When(/^I press enter in "(.*?)"$/) do |field|
  find_field(field).native.send_keys(:return)
end

Then(/^I am redirected to the (.*?) page$/) do |page_name|
  expect(current_path).to eq path_to(page_name)
end

Then(/^I see the (.*?) message "(.*?)"$/) do |type, message|
  expect(page).to have_selector(".alert-#{type}", text: message)
end

Then(/^I see the following (.*?) message:$/) do |type, message|
  message.tr!("\n", ' ')
  step "I see the #{type} message \"#{message}\""
end

Then(/^I see the field "(.*?)" with the error "(.*?)"$/) do |klass, msg|
  form_group =
    first(".form-group.#{klass}") || first('.form-group', text: klass)
  expect(form_group).to have_content(msg)
end

Then(/^I see no errors in the field "(.*?)"$/) do |field|
  form_group = find('.form-group', text: field)
  expect(form_group[:class]).not_to include('has-error')
end

Then(/^I see the page heading "(.*?)"$/) do |title|
  expect(page).to have_selector('.page-header', text: title)
end

Then(/^I see "(.*?)" on the page$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I don't see "(.*?)" on the page$/) do |content|
  expect(page).not_to have_content(content)
end

Then(/^I see the following content on the page:$/) do |content|
  expect(page).to have_content(content)
end

Then(/^the field "(.*?)" is not checked$/) do |checkbox|
  expect(page).to have_unchecked_field(checkbox)
end

Then(/^the field "(.*?)" is checked$/) do |checkbox|
  expect(page).to have_checked_field(checkbox)
end

Then(/^the select "(.*?)" is set to "(.*?)"$/) do |select, value|
  expect(page).to have_select(select, selected: value)
end

Then(/^I see the link "(.*?)" which leads to the "(.*?)" URL$/) do |link, href|
  expect(page).to have_link(link, href: href)
end

Then(/^I see the link "(.*?)"$/) do |link|
  expect(page).to have_link(link)
end

Then(/^I do not see the link "(.*?)"$/) do |link|
  expect(page).not_to have_link(link)
end

Then(/^I see the field "(.*?)" filled in with "(.*?)"$/) do |field, value|
  expect(page).to have_field(field, with: value)
end

Then(/^I see the image "(.*?)"$/) do |image|
  expect(page).to have_selector(:xpath, "//img[contains(@src, '#{image}')]")
end
