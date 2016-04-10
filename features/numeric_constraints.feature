@wip
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
    Then the JSON output should be:
      """json
      {"widgets":2}
      """

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
    Then the JSON output should be:
      """json
      {"proportion":0.0}
      """

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
    Then the JSON output should be:
      """json
      {"quantity":3}
      """

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
    Then the JSON output should be:
      """json
      {"proportion":0.5}
      """

  Scenario: Multiple with minimum
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "wheels": {
            "type": "number",
            "multipleOf": 4,
            "minimum": 5
          }
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      {"wheels":8}
      """
