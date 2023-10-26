module.exports = async (page, scenario, viewport, isReference, browserContext) => {
  console.log('SCENARIO > ' + scenario.label);
  await require('./clickAndHoverHelper')(page, scenario);

  // add more ready handlers here...
  // Scenaro：Click the Playwright in page https://garris.github.io/BackstopJS/
  // Puppeteer API: https://pptr.dev/api
  var selector = 'a[href*="playwright"]';
  const selectObj = page.locator(selector);
  await selectObj.waitFor(30000);
  await selectObj.click(selector);
  await page.waitForFunction("document.readyState == 'complete'", {"timeout":300000});
};
