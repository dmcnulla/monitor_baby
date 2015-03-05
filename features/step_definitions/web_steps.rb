Given(/^a mock server is running on "([^"]*)" and port (\d+)$/) do |host, port|
	@mock_server = MockRestService.new(host, port)
  @mock_server.allow_connections
end

Given(/^the mock server has a message response of "([^"]*)" for GET "([^"]*)"$/) do |message, path|
	@mock_server.store_msg("get", path, message)
end

Given(/^I have a web checker for "([^"]*)"$/) do |url|
	@web = Web.new({ "url"=>url })
end

Given(/^I have a webresponse checker for "([^"]*)" and response "([^"]*)"$/) do |url, body|
	@webresponse = WebResponse.new({ "url"=>url, "body"=>body })
end

When(/^I connect to the web service$/) do
	@actual_result = @web.test?
end

When(/^I connect to the web service to get the response$/) do
	@actual_result = @webresponse.test?
end

Then(/^the expected matches the actual result should be "([^"]*)"$/) do |expected_result|
	expect(@actual_result).to eq(to_bool(expected_result))
end

Then(/^the GET sent was sent to "([^"]*)"$/) do |expected_url|
	last_request =@mock_server.get_last_request
	expect(last_request.include?(expected_url)).to be true
end
