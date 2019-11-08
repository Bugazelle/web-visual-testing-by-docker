module.exports = {
    baseUrl: 'https://github.com/gemini-testing/hermione',
    gridUrl: 'http://127.0.0.1:6666',
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

    browsers: {
        PC: {
            windowSize: '1920x1080',
            desiredCapabilities: {
                browserName: 'chrome',
                chromeOptions: {
                    args: ['--ignore-certificate-errors', '--disable-gpu', '--hide-scrollbars', '--proxy-server=172.17.0.1:3128',],
                },
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
