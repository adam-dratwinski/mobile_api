Feature: Users can browse offers

  Scenario: Users visits offers page
    When I go to the offers page
    Then I should see "No offers" within ".no_offers"

  @vcr
  Scenario: Users browse other user offers
    When I go to the offers page
      And today is "2013-01-20 15:11"
      And I fill in "Uid" with "player1"
      And I fill in "Pub0" with "campaign2"
      And I fill in "Page" with "2"
      And I press "Submit" button

    Then I should see "#offers_section .offer" element
      And I should see "Modern War" within ".offer-title"
