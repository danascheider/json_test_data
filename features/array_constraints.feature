@wip
Feature: Array constraints
  Scenario: Minimum number of items
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "minItems": 4,
        "items": {
          "type": "string",
          "minLength": 3
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      ["aaa","aaa","aaa","aaa"]
      """
