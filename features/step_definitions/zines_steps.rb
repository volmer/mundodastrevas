Given(/^there is a zine with the given attributes:$/) do |table|
  table.hashes.each do |line|
    create :zine, line
  end
end

Given(/^within the zine "(.*?)" there is a post with the given attributes:$/) do |name, table|
  zine = Raddar::Zines::Zine.find_by(name: name)

  table.hashes.each do |line|
    create :zine_post, line.merge(zine: zine)
  end
end

Given(/^there is a zine called "(.*?)"$/) do |name|
  create :zine, name: name
end

Then(/^I see "(.*?)" as the featured zine$/) do |name|
  expect(page).to have_selector('.featured-zine', text: name)
end

Given(/^"(.*?)" is the featured zine$/) do |name|
  zine = create(:zine, name: name)
  Setting[:featured_zine] = zine.id
end

Then(/^there is no featured zine$/) do
  expect(page).not_to have_selector('.featured-zine')
end
