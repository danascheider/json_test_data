Feature: Generating empty objects
  Scenario: Empty object
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {}
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      {}
      """

  Scenario: Array with null
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "items": {}
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      [null]
      """
