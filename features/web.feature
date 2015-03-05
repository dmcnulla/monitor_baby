@web

Feature: As a tester I want to know if a web page is live so that I can save time troubleshooting.

Background: Web server is running
	Given a mock server is running on "localhost" and port 5000

@web.1
Scenario Outline: Verify that the service is open.
	And the mock server has a message response of "whatever" for GET "/index.html"
	And I have a web checker for "<url>"
	When I connect to the web service
	Then the result is "<result>"
	And the GET sent was sent to "<url>"
	Examples: Good case
		| url                              | result |
		| http://localhost:5000/index.html | true   |
		| http://localhost:5000/home.html  | false  |

@web.2
Scenario Outline: Verify that the service returns a string matching a regex, intended for heathchecks
	And the mock server has a message response of "<actual_message>" for GET "/index.html"
	And I have a webresponse checker for "<url>" and response "<expected_message>"
	When I connect to the web service to get the response
	Then the expected matches the actual result should be "<matched>"
	And the GET sent was sent to "<url>"
	@web.2a
	Examples: Simple cases
		| url                              | actual_message | expected_message | matched |
		| http://localhost:5000/index.html | true           | true             | true    |
		| http://localhost:5000/index.html | false          | true             | false   |
	@web.2b
	Examples: Regex cases
		| url                              | actual_message                  | expected_message | matched |
		| http://localhost:5000/index.html | { 'Status': true, 'PID': 123 }  | 'Status': true   | true    |
		| http://localhost:5000/index.html | { 'Status': false, 'PID': 123 } | 'Status': true   | false   |
