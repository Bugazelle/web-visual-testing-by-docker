const assert = require('chai').assert;

// Webdriver api: https://webdriver.io/api.html
// Chai Assert: https://www.chaijs.com/api/assert/

describe('1', function() {
    it('UserActions', function() {
        return this.browser
            .url('https://github.com/gemini-testing/hermione/')
            .click('.url')
            .getTitle()
            .then(function(title) {
                assert.include(title, 'gemini-testing')
            })
            .assertView('plain', 'html')
    });
});