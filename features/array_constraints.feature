Feature: Array constraints
  Scenario: Minimum number of items
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "minItems": 4,
        "items": {
          "type": "number"
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Unique items
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "minItems": 4,
        "items": {
          "type": "number"
        }
      }
      """
    When I run the JSON data generator
    Then the output array should have no duplicate items
