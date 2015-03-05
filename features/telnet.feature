@telnet 

Feature: As a tester I want to know if port is open so that I can save time troubleshooting.

Background: Web server is running
	Given I have a webrick server running on port 5000

# @pause
@telnet.1
Scenario Outline: Verify that the port is open.
	Given I have a telnet checker for "<host>" and <port>
	When I telnet to the service
	Then the result is "<result>"
	Examples: Good case
		| host      | port | result |
		| localhost | 5000 | true   |
		| localhost | 5001 | false  |
