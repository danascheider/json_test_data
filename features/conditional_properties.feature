Feature: Assign values conditionally

  Scenario: Values depend on another property
    Given the following JSON schema:
      """
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "oneOf": [
          { "$ref": "#/definitions/californiaAddress" },
          { "$ref": "#/definitions/floridaAddress"}
        ],
        "definitions": {
          "californiaAddress": {
            "street": { "type": "string" },
            "city": {
              "type": "string",
              "enum": [
                "San Diego",
                "Los Angeles",
                "San Francisco",
                "Sacramento"
              ],
              "state": {
                "type": "string",
                "enum": [ "CA" ]
              },
              "zip": {
                "type": "string",
                "pattern": "\d{5}"
              }
            }
          },
          "floridaAddress": {
            "street": { "type": "string" },
            "city": {
              "type": "string",
              "enum": [
                "Miami",
                "Orlando",
                "St. Petersburg",
                "Tampa",
                "Fort Lauderdale",
                "Tallahassee",
                "Hialeah",
                "Jacksonville"
              ]
            }
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema
