Given(/^I have a checker config "([^"]*)"$/) do |file|
  @config = Configure.new("features/support/data/#{file}")
  @obj = @config.obj
end

When(/^I run the checker$/) do
  @actual_result = @obj.test?
end
