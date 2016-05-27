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
            "required": [ "city", "state" ],
            "properties": {
              "city": {
                "type": "string",
                "enum": [
                  "San Diego",
                  "Los Angeles"
                ]
              },
              "state": {
                "type": "string",
                "enum": [ "CA" ]
              }
            }
          },
          "floridaAddress": {
            "required": [ "city", "state" ],
            "properties": {
              "city": {
                "type": "string",
                "enum": [
                  "Miami",
                  "Orlando"
                ]
              },
              "state": {
                "type": "string",
                "enum": [ "FL" ]
              }
            }
          }
        }
      }
      """
    When I run the JSON data generator
    Then the output should match the schema
