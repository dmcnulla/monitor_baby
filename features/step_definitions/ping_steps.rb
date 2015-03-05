Given(/^I have a ping checker for "([^"]*)"$/) do |host|
	@ping_service = Ping.new({ "host" => host })
end

When(/^I ping the server$/) do
	@actual_result = @ping_service.test?
end

Then(/^the result is "([^"]*)"$/) do |expected_result|
	expect(@actual_result).to eq(to_bool(expected_result))
end
