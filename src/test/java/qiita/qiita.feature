Feature: Karate sample

Background:
* url urlBase


Scenario: Get items

Given path "users", qiita.user_id, "items"
And header Accept = 'application/json'
And param per_page = 5
When method get
Then status 200
And match response == '#[5]'


Scenario Outline: Get item by id

Given path "items", "<item_id>"
And header Accept = 'application/json'
When method get
* print response
Then status 200
And match response.title == "<title>"

Examples:
| item_id | title |
| 29fe013b778919f97e20 | private repository |
| 082396f59e7a62c342c1 | テキストから線表(ガントチャート）を作成するツールを作った |


@ignore
@failcase
Scenario: Get items match fail case

Given path "users", qiita.user_id, "items"
And header Accept = 'application/json'
And param per_page = 5
When method get
* print response
Then status 200
And match response == '#[3]'
