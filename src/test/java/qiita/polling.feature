@polling
Feature: Karate sample2

Background:
* url urlBase
* def waitUntil = 
"""
function(options) {
    karate.log(options.item_id);
    for (var i=0; i< 6 ;i++) {
        java.lang.Thread.sleep(10000);
        var result = karate.call('./libs/GetItem.feature', {id: options.item_id});
        var item = result.response;
        if (item.likes_count >= options.desired_count){
            karate.log('いいねが押されたよ');
            return 0;
        }
        karate.log('waiting...');
    }
    return -1;
}
"""


Scenario: Wait 

* def item_id = '90c9a093384375f9beca'
* def result = call read('./libs/GetItem.feature') {id: #(item_id)}
* def current = result.response.likes_count
* print 'current likes_count: ' + current
* def target = current + 1 
* def ret = call waitUntil {item_id: #(item_id),  desired_count: #(target) }
* match ret == 0