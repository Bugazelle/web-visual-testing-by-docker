module.exports = {
    rootUrl: 'http://detectmobilebrowsers.com/',
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
        firefox: {
            files: 'demo.js',
            browsers: ['iPhone5_SE', 
                       'SamsungGalaxy_Note_4',
                       'iPadMini_Air',
                       'iPadPro_12Inches',
                       'PC1',
                       'PC2'],
        },
    },

    // Firefox Args: https://developer.mozilla.org/en-US/docs/Mozilla/Command_Line_Options
    // Firefox Capabilities: https://developer.mozilla.org/en-US/docs/Web/WebDriver/Capabilities/firefoxOptions
    // Selenium Capabilities: https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities
    browsers: {
        // 320 - 480
        iPhone5_SE: {
            windowSize: '320x568',
            desiredCapabilities: {
                browserName: 'firefox',
                proxy: {
                    proxyType: 'manual',
                    httpProxy: '172.17.0.1:3128',
                    sslProxy: '172.17.0.1:3128',
                },
                acceptInsecureCerts: true,
                trustAllSSLCertificates: true,
                'moz:firefoxOptions': {
                    'prefs': {
                        "general.useragent.override": "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1",
                    },
                },
            },
        },

        // 480 - 768
        SamsungGalaxy_Note_4: {
            windowSize: '480x853',
            desiredCapabilities: {
                browserName: 'firefox',
                proxy: {
                    proxyType: 'manual',
                    httpProxy: '172.17.0.1:3128',
                    sslProxy: '172.17.0.1:3128',
                },
                acceptInsecureCerts: true,
                trustAllSSLCertificates: true,
                'moz:firefoxOptions': {
                    'prefs': {
                        "general.useragent.override": "Mozilla/5.0 (Linux; Android 6.0.1; tr-tr; SAMSUNG SM-N910C Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/2.0 Chrome/65.0.3325.109 Mobile Safari/537.36",
                    },
                },
            },
        },

        // 768 - 960
        iPadMini_Air: {
            windowSize: '768x1024',
            desiredCapabilities: {
                browserName: 'firefox',
                proxy: {
                    proxyType: 'manual',
                    httpProxy: '172.17.0.1:3128',
                    sslProxy: '172.17.0.1:3128',
                },
                acceptInsecureCerts: true,
                trustAllSSLCertificates: true,
                'moz:firefoxOptions': {
                    'prefs': {
                        "general.useragent.override": "Mozilla/5.0 (iPad; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/65.0.3325.109 Mobile/15A5327g Safari/602.1",
                    },
                },
            },
        },

        // 960 - 1164
        iPadPro_12Inches: {
            windowSize: '1024x1366',
            desiredCapabilities: {
                browserName: 'firefox',
                proxy: {
                    proxyType: 'manual',
                    httpProxy: '172.17.0.1:3128',
                    sslProxy: '172.17.0.1:3128',
                },
                acceptInsecureCerts: true,
                trustAllSSLCertificates: true,
                'moz:firefoxOptions': {
                    'prefs': {
                        "general.useragent.override": "Mozilla/5.0 (iPad; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/65.0.3325.109 Mobile/15A5327g Safari/602.1",
                    },
                },
            },
        },

        // 1164 -
        PC1: {
            windowSize: '1164x850',
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

        // 1920 -
        PC2: {
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