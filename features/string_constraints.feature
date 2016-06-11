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
    Then the output should match the schema

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
    Then the output should match the schema

  Scenario: Possible values given
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "enum": [
              "foo",
              "bar",
              "baz"
            ]
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Date-time format
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "date": {
            "type": "string",
            "format": "date-time"
          }
        }
      }
      """
      When I run the JSON data generator
      Then the output should match the schema
