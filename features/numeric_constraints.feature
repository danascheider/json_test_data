Feature: Numeric constraints
  Scenario: Number must be divisible by some factor
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
    Then the output should match the schema

  Scenario: Number has a maximum value
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "proportion": {
            "type": "number",
            "maximum": 0.25
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Number has a minimum value
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "quantity": {
            "type": "integer",
            "minimum": 2
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Maximum and minimum
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "proportion": {
            "type": "number",
            "maximum": 1,
            "minimum": 0,
            "exclusiveMinimum": true
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Multiple with minimum
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "wheels": {
            "type": "integer",
            "multipleOf": 4,
            "minimum": 5
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema
