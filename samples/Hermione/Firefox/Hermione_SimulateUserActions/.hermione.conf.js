module.exports = {
    baseUrl: 'https://github.com/gemini-testing/hermione/',
    gridUrl: 'http://127.0.0.1:4444/wd/hub',
    tolerance: 3.6,
    compositeImage: true,
    sessionsPerBrowser: 4,
    retry: 3,
    screenshotMode: 'viewport',
	waitTimeout: 30000,
    screenshotDelay: 1000,

    sets: {
        chrome: {
            files: 'demo.js',
            browsers: ['PC'],
        },
    },

    // Firefox Args: https://developer.mozilla.org/en-US/docs/Mozilla/Command_Line_Options
    // Firefox Capabilities: https://developer.mozilla.org/en-US/docs/Web/WebDriver/Capabilities/firefoxOptions
    // Selenium Capabilities: https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities
    // Webdriver IO Configurations: https://github.com/webdriverio/webdriverio/blob/dd4a37b74742267bb81b8f2e6065fed5aebc7746/docs/ConfigurationFile.md
    browsers: {
        PC: {
            windowSize: '1920x1080',
            desiredCapabilities: {
                browserName: 'firefox',
                proxy: {
                    proxyType: 'manual',
                    httpProxy: '172.17.0.1:3128',
                    sslProxy: '172.17.0.1:3128',
                },
                acceptInsecureCerts: true,
                trustAllSSLCertificates: true,
            },
        },
    },

    plugins: {
        'html-reporter/hermione': {
            enabled: true,
            path: 'hermione-report',
        },
        'json-reporter/hermione': {
            enabled: true,
            path: 'hermione-report.json',
        },
    },

    system: {
        parallelLimit: 5,
    	debug: false,
        mochaOpts: {
            timeout: 60000,
        },
    },

};
