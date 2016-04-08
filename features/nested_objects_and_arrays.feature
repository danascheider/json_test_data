@wip
Feature: Support nested objects and arrays

  Scenario: Object in an array
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string"
            },
            "id": {
              "type": "integer"
            },
            "admin": {
              "type": "boolean"
            }
          }
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      [{"name":"string","id":1,"admin":true}]
      """

  Scenario: Array in an object
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "users": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      {"users":["string"]}
      """
