@ping

Feature: As a tester I want to know that the server is running so that I can save time troubleshooting.

@ping.1
Scenario Outline: Handles a ping for server or ip address
	Given I have a ping checker for "<host>"
	When I ping the server
	Then the result is "<result>"
	Examples: Good case
		| host        | result |
		| localhost   | true   |
		| google.com  | true   |
		| 192.168.0.1 | true   |
	Examples: Bad host case
		| host       | result |
		| no_server  | false  |
		| 0.42.42.42 | false  |
	@slow
	Examples: Bad host case
		| host       | result |
		| gooble.com | false  |
