Feature: Generate test data
  Scenario: Simple object
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "id": {
            "type": "number"
          }
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      {"id":1}
      """

  Scenario: Simple array
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "items": {
          "type": "number"
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      [1]
      """
