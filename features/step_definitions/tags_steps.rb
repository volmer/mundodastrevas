Given(/^there is a post named "(.*?)" tagged as "(.*?)"$/) do |post_name, tag_name|
  post = create(:post, name: post_name)
  tag = Raddar::Tag.find_by(name: tag_name) || create(:tag, name: tag_name)
  create(:tagging, tag: tag, taggable: post)
end

Given(/^there are (\d+) posts tagged as "(.*?)"$/) do |count, tag_name|
  tag = Raddar::Tag.find_by(name: tag_name) || create(:tag, name: tag_name)

  create_list(:post, count.to_i).each do |post|
    create(:tagging, tag: tag, taggable: post)
  end
end

Then(/^I see (\d+) tag results$/) do |count|
  expect(page).to have_selector('.tag-result', count: count)
end
