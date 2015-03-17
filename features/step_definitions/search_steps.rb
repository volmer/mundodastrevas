Then(/^I see (\d+) search results$/) do |count|
  expect(page).to have_selector('.search-result', count: count)
end
