const assert = require('chai').assert;

// Webdriver api: https://webdriver.io/api.html
// Chai Assert: https://www.chaijs.com/api/assert/

describe('1', function() {
    it('devices', function() {
        return this.browser
            .url('http://detectmobilebrowsers.com/')
            .execute(function() {
            	document.querySelector('ins').style.display='none';
            })
            .assertView('plain', 'html', {ignoreElements: ['ins']})
    });
});