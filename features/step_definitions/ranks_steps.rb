Given(/^within "(.*?)" there is a rank with:$/) do |universe_name, table|
  universe = Universe.find_by(name: universe_name)

  table.hashes.each do |line|
    create :rank, line.merge(universe: universe, value: 2)
  end
end

Given(/^I have earned the rank "(.*?)" in "(.*?)"$/) do |name, universe_name|
  universe = Universe.find_by(name: universe_name)
  rank = universe.ranks.find_by(name: name)

  create_list(:comment, 10, user: @user, universe: universe)

  LevelGrantor.level_up!(@user, universe)

  expect(@user.rank_in(universe)).to eq(rank)
end
