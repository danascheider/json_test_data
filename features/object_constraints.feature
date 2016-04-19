Feature: Object constraints
  Scenario: Object has no specified properties
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object"
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      {}
      """

  Scenario: Minimum number of properties
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "minProperties": 3,
        "properties": {
        }
      }
      """
    When I run the JSON data generator
    Then JSON output should have 3 properties
