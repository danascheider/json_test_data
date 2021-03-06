Feature: Generating empty objects
  Scenario: Empty object
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {}
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Array with null
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "items": {}
      }
      """
    When I run the JSON data generator
    Then the output should match the schema

  Scenario: Ruby hash
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {}
      }
      """
    When I run the JSON data generator with the "ruby" option
    Then the output should be a Ruby hash


  Scenario: Ruby array
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "array",
        "items": {}
      }
      """
    When I run the JSON data generator with the "ruby" option
    Then the output should be a Ruby array
