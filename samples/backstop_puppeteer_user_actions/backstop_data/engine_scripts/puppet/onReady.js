module.exports = async (page, scenario, vp) => {
  console.log('SCENARIO > ' + scenario.label);
  await require('./clickAndHoverHelper')(page, scenario);

  // add more ready handlers here...
  // Scenaro：Click the Puppeteer in page https://garris.github.io/BackstopJS/
  // Puppeteer API: https://pptr.dev/api
  var selector = 'a[href*="puppeteer"]';
  await page.waitForSelector(selector, {"timeout":300000});
  await page.click(selector);
  await page.waitForFunction("document.readyState == 'complete'", {"timeout":300000});
};

