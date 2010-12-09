Feature: Autocomplete
  In order to do funky stuff
  As a User
  I want autocomplete!

  Background: 
    Given the following brands exists:
      | id  | name  |
      | 1   | Alpha |
      | 2   | Beta  |
      | 3   | Gamma |

  @javascript
  Scenario: Autocomplete
    Given I go to the home page
    And I fill in "Brand name" with "al"
    And I choose "Alpha" in the autocomplete list
    Then the "Brand name" field should contain "Alpha"

