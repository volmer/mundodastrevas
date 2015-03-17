Given(/^there is a page with the following data:$/) do |table|
  table.hashes.each do |line|
    create :page, line
  end
end

Given(/^there is a page titled "(.*?)"$/) do |title|
  create(:page, title: title)
end

Given(/^there are (\d+) pages$/) do |count|
  create_list(:page, count.to_i)
end

Given(/^there are (\d+) pages titled "(.*?)"$/) do |count, title|
  create_list(:page, count.to_i, title: title)
end

Then(/^I see (\d+) pages listed$/) do |count|
  expect(page).to have_selector('tr.page', count: count)
end
