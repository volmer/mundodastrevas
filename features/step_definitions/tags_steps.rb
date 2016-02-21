Given(/^there is a post named "(.*?)" tagged as "(.*?)"$/) do |post, tag_name|
  post = create(:post, name: post)
  tag = Tag.find_by(name: tag_name) || create(:tag, name: tag_name)
  create(:tagging, tag: tag, taggable: post)
end

Given(/^there are (\d+) posts tagged as "(.*?)"$/) do |count, tag_name|
  tag = Tag.find_by(name: tag_name) || create(:tag, name: tag_name)

  create_list(:post, count.to_i).each do |post|
    create(:tagging, tag: tag, taggable: post)
  end
end

Then(/^I see (\d+) tag results$/) do |count|
  expect(page).to have_selector('.tag-result', count: count)
end
