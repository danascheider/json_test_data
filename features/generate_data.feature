Feature: Generate test data
  Scenario: Simple object
    Given the following JSON schema:
      """
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          }
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """
      { "name": "string" }
      """
