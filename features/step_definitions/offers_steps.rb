When /^I go to the offers page$/ do
  visit offers_path
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in field, :with => value
end

When /^I press "(.*?)" button$/ do |label|
  click_button(label)
end

Then /^I should see "(.*?)" element$/ do |selector|
  page.has_selector?(selector).should == true
end

Then /^I should see "(.*?)" within "(.*?)"$/ do |text, selector|
  page.should have_selector(selector, :text => /#{text}/i)
end

When /^today is "(.*?)"$/ do |arg1|
  Timecop.freeze(arg1)
end
