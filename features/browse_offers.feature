Feature: Users can browse offers

  Scenario: Users visits offers page
    When I go to the offers page
    Then I should see "No offers" within ".no_offers"

  Scenario: Users browse other user offers
    When I go to the offers page
      And I fill in "Uid" with "player1"
      And I fill in "Pub0" with "campaign2"
      And I fill in "Page" with "0"
      And I press "Submit" button

    Then I should see "#offers_section .offer" element
      And I should see "Offer Title" within ".offer .title"
      And I should see "Offer Payout" within ".offer .payout"
      And I should see "Offer Thumbnail" within ".offer .thumbnail"
