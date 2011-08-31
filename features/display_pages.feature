Feature: Display pages
  As a user
  I should see pages that have been stored
  So that I can navigate the content in the system
  
  Scenario Outline:
    Given a page exists with slug: "<slug>", title: "<title>", content: "<content>"
    When I visit "/<slug>"
    Then I should see "<content>" with title "<title>"
    
    Examples:
      | slug           | title             | content                         |
      | welcome        | Welcome!          | This is my welcome page.        |
      | angle-brackets | Angle <> Brackets | This page has <angle brackets>. |