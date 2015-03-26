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
	And I have a webresponse checker for "http://localhost:5000/index.html" and response "<expected_message>"
	When I connect to the web service to get the response
	Then the expected matches the actual result should be "<matched>"
	And the GET sent was sent to "http://localhost:5000/index.html"
	@web.2a
	Examples: Simple cases
		| actual_message | expected_message | matched |
		| true           | true             | true    |
		| false          | true             | false   |
	@web.2b
	Examples: Regex cases
		| actual_message                  | expected_message | matched |
		| { 'Status': true, 'PID': 123 }  | 'Status': true   | true    |
		| { 'Status': false, 'PID': 123 } | 'Status': true   | false   |

@web.3
Scenario Outline: Verify that the service verifies the response code & response time
	And the mock server has a response code of "<actual_code>" for GET "/index.html"
	And I have a webtime checker for "http://localhost:5000/index.html" for code "<expected_code>" and time "<expected_time>"
	When I connect to the web service to get the response time
	Then the expected matches the actual result should be "<result>"
	@web.3a
	Examples: positive cases
		| actual_code | expected_code | expected_time | result |
		| 200         | 200           | 1000          | true   |
		| 204         | 204           | 1000          | true   |
	@web.3b
	Examples: negative cases
		| actual_code | expected_code | expected_time | result |
		| 400         | 200           | 1000          | false  |
		| 204         | 200           | 1000          | false  |
		| 200         | 200           | 10            | false  |
