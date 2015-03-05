@log_entry

Feature: As a tester, I want a tool that can retain notations so I can see them laster.


@log_entry.1
Scenario: Service knows it's name
	Given I have an entry logger "test_cuke"
	Then the entry logger is called "test_cuke"

@log_entry.2
Scenario: Add a new entry
	Given I have an entry logger "test_cuke"
	When I add a new entry "test entries"
	Then the size grows
	And the last entry contains "test entries"

@log_entry.3
Scenario: Add a group of new entries
	Given I have an entry logger "test_cuke"
	When I add a new entries
	| Entries      |
	| test entry 1 |
	| test entry 2 |
	Then the size grows
	And the first entry contains "test entry 1"
	And the last entry contains "test entry 2"
