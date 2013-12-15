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
