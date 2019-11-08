module.exports = async (page, scenario, vp) => {
  console.log('SCENARIO > ' + scenario.label);
  await require('./clickAndHoverHelper')(page, scenario);

  // add more ready handlers here...

  var selector = 'a[href="https://github.com/garris/BackstopJS"]';
  await page.waitForSelector(selector, {"timeout":300000});
  await page.click(selector);
  await page.waitForFunction("document.readyState == 'complete'", {"timeout":300000});

};
