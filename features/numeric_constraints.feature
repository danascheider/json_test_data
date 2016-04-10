@wip
Feature: Numeric constraints
  Scenario: Number must be divisible by something
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "widgets": {
            "type": "integer",
            "multipleOf": 2
          }
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      {"widgets":2}
      """
