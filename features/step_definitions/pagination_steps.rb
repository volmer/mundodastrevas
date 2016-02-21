Then(/^I see (\d+) pages$/) do |pages|
  last_page = all('.pagination .page a').last
  expect(last_page.text).to eq pages
end

Then(/^I see (.*?) in the page (\d+)$/) do |items, page|
  within('.pagination') { click_on page }

  step("I see #{items}")
end
