@ignore
Feature: Get item

Background:
* url urlBase


Scenario: Get item

Given path "items", id
And header Accept = 'application/json'
When method get
Then status 200
