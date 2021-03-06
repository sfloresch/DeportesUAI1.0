@core @core_tag
Feature: Users can flag tags and manager can reset flags
  In order to use tags
  As a user
  I need to be able to flag the tag as inappropriate

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | manager1 | Manager   | 1        | manager1@example.com |
      | user1    | User      | 1        | user1@example.com    |
      | user2    | User      | 2        | user2@example.com    |
      | user3    | User      | 3        | user3@example.com    |
    And the following "system role assigns" exist:
      | user     | course               | role    |
      | manager1 | Acceptance test site | manager |
    And the following "tags" exist:
      | name         | tagtype  |
      | Neverusedtag | official |
    And I log in as "user1"
    And I navigate to "Site blogs" node in "Site pages"
    And I follow "Add a new entry"
    And I set the following fields to these values:
      | Entry title                                 | Blog post from teacher    |
      | Blog entry body                             | Teacher blog post content |
      | Other tags (enter tags separated by commas) | Nicetag, Badtag, Sweartag |
    And I press "Save changes"
    And I log out
    And I log in as "user2"
    And I navigate to "Site blogs" node in "Site pages"
    And I follow "Badtag"
    And I follow "Flag as inappropriate"
    And I should see "The person responsible will be notified"
    And I follow "Continue"
    And I navigate to "Site blogs" node in "Site pages"
    And I follow "Sweartag"
    And I follow "Flag as inappropriate"
    And I should see "The person responsible will be notified"
    And I follow "Continue"
    And I log out
    And I log in as "user3"
    And I navigate to "Site blogs" node in "Site pages"
    And I follow "Sweartag"
    And I follow "Flag as inappropriate"
    And I should see "The person responsible will be notified"
    And I follow "Continue"
    And I log out

  Scenario: Managing tag flags with javascript disabled
    When I log in as "manager1"
    And I navigate to "Manage tags" node in "Site administration > Appearance"
    Then "Sweartag" "link" should appear before "Badtag" "link"
    And "Badtag" "link" should appear before "Nicetag" "link"
    And "(2)" "text" should exist in the "//tr[contains(.,'Sweartag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(1)" "text" should exist in the "//tr[contains(.,'Badtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Nicetag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Neverusedtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And I click on "Reset flag" "link" in the "Sweartag" "table_row"
    And I click on "Reset flag" "link" in the "Badtag" "table_row"
    And I click on "Flag as inappropriate" "link" in the "Sweartag" "table_row"
    And I click on "Flag as inappropriate" "link" in the "Nicetag" "table_row"
    And "(1)" "text" should exist in the "//tr[contains(.,'Sweartag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(1)" "text" should exist in the "//tr[contains(.,'Nicetag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Badtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Neverusedtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And I log out

  @javascript
  Scenario: Managing tag flags with javascript enabled
    When I log in as "manager1"
    And I navigate to "Manage tags" node in "Site administration > Appearance"
    Then "Sweartag" "link" should appear before "Badtag" "link"
    And "Badtag" "link" should appear before "Nicetag" "link"
    And "(2)" "text" should exist in the "//tr[contains(.,'Sweartag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(1)" "text" should exist in the "//tr[contains(.,'Badtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Nicetag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Neverusedtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And I click on "Reset flag" "link" in the "Sweartag" "table_row"
    And I click on "Reset flag" "link" in the "Badtag" "table_row"
    And I wait until "//tr[contains(.,'Sweartag')]//a[contains(@title,'Flag as inappropriate')]" "xpath_element" exists
    And I click on "Flag as inappropriate" "link" in the "Sweartag" "table_row"
    And I click on "Flag as inappropriate" "link" in the "Nicetag" "table_row"
    And "(1)" "text" should exist in the "//tr[contains(.,'Sweartag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(1)" "text" should exist in the "//tr[contains(.,'Nicetag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Badtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Neverusedtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And I follow "Manage tags"
    And "Nicetag" "link" should appear before "Sweartag" "link"
    And "Sweartag" "link" should appear before "Badtag" "link"
    And "(1)" "text" should exist in the "//tr[contains(.,'Sweartag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(1)" "text" should exist in the "//tr[contains(.,'Nicetag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Badtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And "(" "text" should not exist in the "//tr[contains(.,'Neverusedtag')]//td[contains(@class,'col-flag')]" "xpath_element"
    And I log out
