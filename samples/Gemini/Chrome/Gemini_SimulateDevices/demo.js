gemini.suite('1', function(suite) { 
	suite.setUrl('http://detectmobilebrowsers.com/') 
	.before(function(actions) { actions.wait(1000); }) 
	.setCaptureElements('html') 
	// Not working well with ignoreElements
	// .ignoreElements({every: 'ins'})
	// Use javascript instead
	.capture('plain', function(actions) {
        actions.executeJS(function() {
			document.querySelector('ins').style.display='none';
		});
    })
});
