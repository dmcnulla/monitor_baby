@checkers
@wip

Feature: As a tester I want to create checkers from a config file so I can know they can be used after restarts.

Background: 
	Given I have a webrick server running on port 5000
	And I have a ping checker for "<0.42.42.42>"
	And I have a telnet checker for "<host>" and <port>
	And I have a web checker for "<url>"

@checkers.1
Scenario: I have three types of checkers at once
