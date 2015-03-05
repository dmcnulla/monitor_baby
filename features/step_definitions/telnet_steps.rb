Given(/^I have a webrick server running on port (\d+)$/) do |port|
	expect(`netstat -anp|grep #{port}|grep 0.0.0.0`.split[-1].split('/')[0].to_i).to be > 0
end

Given(/^I have a telnet checker for "([^"]*)" and (\d+)$/) do |host, port|
	@telnet = Telnet.new({ "host"=>host, "port"=>port.to_i })
end

When(/^I telnet to the service$/) do
	@actual_result = @telnet.test?
end
