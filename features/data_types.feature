@wip
Feature: Handling data types

  The data generated needs to have the correct properties or items, including
  the data type specified

  Scenario: Strings
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          }
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      {"name":"string"}
      """

  Scenario: Numbers
    Given the following JSON schema:
      """json
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "id": {
            "type": "number"
          }
        }
      }
      """
    When I run the JSON data generator
    Then the JSON output should be:
      """json
      {"id":1}
      """
