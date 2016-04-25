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
    Then the output should match the schema

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
              "type": "number"
            }
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Array in an array
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "items": {
          "type": "array",
          "items": {
            "type": "number"
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: More complex nested object
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "id": {
              "type": "number"
            },
            "dossier": {
              "type": "object",
              "properties": {
                "height_in_feet": {
                  "type": "number"
                },
                "favorite_foods": {
                  "type": "array",
                  "items": {
                    "type": "number"
                  }
                }
              }
            },
            "admin": {
              "type": "boolean"
            }
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema
