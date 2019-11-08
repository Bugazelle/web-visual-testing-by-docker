module.exports = {
    baseUrl: 'http://detectmobilebrowsers.com/',
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
            browsers: ['iPhone5_SE', 
                       'SamsungGalaxy_Note_4',
                       'iPadMini_Air',
                       'iPadPro_12Inches',
                       'PC1',
                       'PC2'],
        },
    },

    browsers: {
        // 320 - 480
        iPhone5_SE: {
            desiredCapabilities: {
                browserName: 'chrome',
                chromeOptions: {
                    args: ['--ignore-certificate-errors', '--disable-gpu', '--hide-scrollbars', '--proxy-server=172.17.0.1:3128',],
                    mobileEmulation: {
                        userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/65.0.3325.109 Mobile/14E5239e Safari/602.1',
                        deviceMetrics: {
                            width: 320,
                            height: 568,
                            // Disable the scroll bar
                            mobile: false,
                            touch: false,
                        },
                    },
                },
            },
        },

        // 480 - 768
        SamsungGalaxy_Note_4: {
            desiredCapabilities: {
                browserName: 'chrome',
                chromeOptions: {
                    args: ['--ignore-certificate-errors', '--disable-gpu', '--hide-scrollbars', '--proxy-server=172.17.0.1:3128',],
                    mobileEmulation: {
                        userAgent: 'Mozilla/5.0 (Linux; Android 6.0.1; tr-tr; SAMSUNG SM-N910C Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/2.0 Chrome/65.0.3325.109 Mobile Safari/537.36',
                        deviceMetrics: {
                            width: 480,
                            height: 853,
                            // Disable the scroll bar
                            mobile: false,
                            touch: false,
                        },
                    },
                },
            },
        },

        // 768 - 960
        iPadMini_Air: {
            desiredCapabilities: {
                browserName: 'chrome',
                chromeOptions: {
                    args: ['--ignore-certificate-errors', '--disable-gpu', '--hide-scrollbars', '--proxy-server=172.17.0.1:3128',],
                    mobileEmulation: {
                        userAgent: 'Mozilla/5.0 (iPad; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/65.0.3325.109 Mobile/15A5327g Safari/602.1',
                        deviceMetrics: {
                            width: 768,
                            height: 1024,
                            // Disable the scroll bar
                            mobile: false,
                            touch: false,
                        },
                    },
                },
            },
        },

        // 960 - 1164
        iPadPro_12Inches: {
            desiredCapabilities: {
                browserName: 'chrome',
                chromeOptions: {
                    args: ['--ignore-certificate-errors', '--disable-gpu', '--hide-scrollbars', '--proxy-server=172.17.0.1:3128',],
                    mobileEmulation: {
                        userAgent: 'Mozilla/5.0 (iPad; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/65.0.3325.109 Mobile/15A5327g Safari/602.1',
                        deviceMetrics: {
                            width: 1024,
                            height: 1366,
                            // Disable the scroll bar
                            mobile: false,
                            touch: false,
                        },
                    },
                },
            },
        },

        // 1164 -
        PC1: {
            windowSize: '1164x850',
            desiredCapabilities: {
                browserName: 'chrome',
                chromeOptions: {
                    args: ['--ignore-certificate-errors', '--disable-gpu', '--hide-scrollbars', '--proxy-server=172.17.0.1:3128',],
                },
            },
        },

        // 1920 -
        PC2: {
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
