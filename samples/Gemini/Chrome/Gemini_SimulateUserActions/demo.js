gemini.suite('1', function(suite) { 
	suite.setUrl('https://github.com/gemini-testing/gemini/releases') 
	.before(function(actions, find) { 
		actions.wait(1000); 
		this.button = find('.url');
		actions.click(this.button);
		actions.waitForJSCondition(function() {
			return document.readyState == 'complete';
		}, 120000);
	}) 
	.setCaptureElements('html') 
	.capture('plain', function(actions, find) {
		// The wait is necessary, do not delete it
		actions.wait(1000);
	})
});
