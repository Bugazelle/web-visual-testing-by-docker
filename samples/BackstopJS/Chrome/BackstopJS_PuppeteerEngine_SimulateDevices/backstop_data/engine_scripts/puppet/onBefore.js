module.exports = async (page, scenario, vp) => {
  await require('./loadCookies')(page, scenario);

  // Emulate Different Devices
  if (vp.label.includes('iPhone')) {
	await page.setUserAgent('Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/65.0.3325.109 Mobile/14E5239e Safari/602.1');
  } else if (vp.label.includes('iPad')) {
  	await page.setUserAgent('Mozilla/5.0 (iPad; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/65.0.3325.109 Mobile/15A5327g Safari/602.1');
  } else if (vp.label.includes('Samsung')) {
  	await page.setUserAgent('Mozilla/5.0 (Linux; Android 6.0.1; tr-tr; SAMSUNG SM-N910C Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/2.0 Chrome/65.0.3325.109 Mobile Safari/537.36');
  } else {
  	await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36');
  }

  // Custom Timeout
  await page.setDefaultNavigationTimeout(300000);
  
};
