Feature: Assign values conditionally
  Scenario: Multiple schemas inline
    Given the following JSON schema:
      """
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "oneOf": [
          {
            "required": [ "foo", "bar" ],
            "properties": {
              "foo": { "type": "string" },
              "bar": { "type": "integer" }
            }
          },
          {
            "required": [ "baz", "qux" ],
            "properties": {
              "baz": { "type": "string" },
              "qux": { "type": "string" }
            }
          }
        ]
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Multiple schemas with refs
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
