Feature: String constraints
  Scenario: Maximum length is short
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "maxLength": 2
          }
        }
      }
      """
    When I run the JSON data generator
    Then the "name" property of the JSON output should be a string of length 2

  Scenario: Minimum length is long
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "minLength": 8
          }
        }
      }
      """
    When I run the JSON data generator
    Then the "name" property of the JSON output should be a string of length 8
