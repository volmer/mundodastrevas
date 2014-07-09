Given(/^there is an universe with the following attributes:$/) do |table|
  table.hashes.each do |line|
    create :universe, line
  end
end

Given(/^there is an universe called "(.*?)"$/) do |name|
  create :universe, name: name
end

Given(/^the "(.*?)" universe has ranks with users$/) do |name|
  universe = Universe.find_by!(name: name)
  rank = create(:rank, universe: universe)
  create(:level, value: rank.value, universe: universe)
end

When(/^I open the "(.*?)" universe page$/) do |name|
  universe = Universe.find_by!(name: name)

  visit universe_path(universe)
end
