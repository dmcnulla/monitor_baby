@log 

Feature: As a tester I want to know if a log has any particular message so that I can save time troubleshooting.

@log.1
Scenario Outline: Verify the log entries are found and reported as true.
	Given I have a log file "test_server.log" with the following
		"""
		<message>
		"""
	And I have a log checker for "test_server.log" and "<search_list>"
	When I test the log
	Then the result is "<result>"
	Examples: Single search string
		| message                              | search_list | result |
		| 2014-12-30 INFO good things happened | ERROR       | true   |
		| 2014-12-30 ERROR bad things happened | ERROR       | false  |
	Examples: Multiple search string
		| message                               | search_list | result |
		| 2014-12-30 INFO good things happened  | ERROR,WARN  | true   |
		| 2014-12-30 INFO weird things happened | ERROR,weird | false  |

@log.2
Scenario Outline: Verify the entries can be retrieved
	Given I have a log file "test_server.log" with the following
		"""
		<message>
		"""
	And I have a log checker for "test_server.log" and "<search_list>"
	When I test the log
	Then the log checker found <found_entries> entries
	And the last noted entry contains "<last_found>"
	Examples: Single search strings
		| message                              | search_list | found_entries | last_found |
		| 2014-12-30 INFO good things happened | ERROR       | 0             |            |
		| 2014-12-30 ERROR bad things happened | ERROR       | 1             | bad things      |
	Examples: Multiple search string
		| message                               | search_list | found_entries | last_found   |
		| 2014-12-30 INFO good things happened  | ERROR,WARN  | 0             |              |
		| 2014-12-30 INFO weird things happened | ERROR,weird | 1             | weird things |
		| ERROR 1\nWEIRD 2\nINFO 3              | ERROR,WEIRD | 2             | WEIRD        |
