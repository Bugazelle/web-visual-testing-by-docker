module.exports = {
    rootUrl: 'https://github.com/gemini-testing/gemini/releases',
    gridUrl: 'http://127.0.0.1:4444/wd/hub',
    sessionRequestTimeout: 120000,
    tolerance: 3.6,
    compositeImage: true,
    sessionsPerBrowser: 4,
    retry: 3,
    screenshotMode: 'fullpage',
    httpTimeout: 60000,
    sessionQuitTimeout: 30000,

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
                browserName: 'firefox',
                proxy: {
                    proxyType: 'manual',
                    httpProxy: '172.17.0.1:3128',
                    sslProxy: '172.17.0.1:3128',
                },
                trustAllSSLCertificates: true,
                acceptInsecureCerts: true,
            },
        },
    },

    system: {
        parallelLimit: 5,
        plugins: {
            'html-reporter-legacy/gemini': {
                enabled: true,
                path: 'gemini-report',
            },
            'json-reporter/gemini': {
                enabled: true,
                path: 'gemini-report.json',
            },
        },
        debug: false,
    },

};