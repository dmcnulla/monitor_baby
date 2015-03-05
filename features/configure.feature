@configure

Feature: As a tester I want to configure a checker through a yml file so I can change the checker easily.

@configure.1
Scenario Outline: A checker is read from a yaml file.
  Given I have a checker config "<file>"
  When I run the checker
  Then the result is "<result>"
  @configure.ping
  Examples: Ping
    | file         | result |
    | ping1.yaml   | true   |
    | ping2.yaml   | false  |
  @configure.telnet
  Examples: telnet
    | file         | result |
    | telnet1.yaml | true   |
    | telnet2.yaml | false  |
  @configure.log
  Examples: log file
    | file         | result |
    | log1.yaml    | true   |
    | log2.yaml    | false  |

@configure.2
Scenario Outline: A checker is read from a yaml file.
  Given a mock server is running on "localhost" and port 5000
  And the mock server has a message response of "<response>" for GET "/index.html"
  And I have a checker config "<file>"
  When I run the checker
  Then the result is "<result>"
  @configure.web
  Examples: web service available
    | file              | response                       | result |
    | web1.yaml         | true                           | true   |
    | web2.yaml         | anything                       | false  |
  @configure.webresponse
  Examples: web service response
    | file              | response                       | result |
    | webresponse1.yaml | { 'Status': true, 'PID': 123 } | true   |
    | webresponse2.yaml | { 'Status': true, 'PID': 123 } | false   |
