module.exports = () => {
  const config = {
    baseURL: 'https://github.com/SeleniumHQ/selenium/releases/download',
    version: process.env.SELENIUM_VERSION || '4.4.0',
    drivers: {
      chrome: {
        version: 'latest',
        fallbackVersion: '106.0.5249.61',
        arch: process.arch,
        baseURL: 'https://chromedriver.storage.googleapis.com',
      },
      firefox: {
        version: 'latest',
        fallbackVersion: '0.32.0',
        arch: process.arch,
        baseURL: 'https://github.com/mozilla/geckodriver/releases/download',
      },
    },
  };

  return config;
};