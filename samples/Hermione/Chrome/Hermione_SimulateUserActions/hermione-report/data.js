var data = {"skips":[],"suites":[{"name":"1","suitePath":["1"],"children":[{"name":"UserActions","suitePath":["1","UserActions"],"browsers":[{"name":"PC","result":{"suiteUrl":"https://github.com/gemini-testing/hermione/","name":"PC","metaInfo":{"pid":13561,"url":"/gemini-testing/hermione/","file":"demo.js","sessionId":"cb7feb0f2746fc2a46a3504e4ba9486e"},"imagesInfo":[{"stateName":"plain","refImg":{"path":"/tmp/Sample/Hermione/Chrome/Hermione_SimulateUserActions/hermione/screens/bd90ad3/PC/plain.png","size":{"width":1896,"height":5124}},"status":"success","expectedImg":{"path":"images/bd90ad3/plain/PC~ref_0.png","size":{"width":1896,"height":5124}}}],"screenshot":false,"multipleTabs":true,"status":"success","attempt":0},"retries":[]}],"status":"success"}],"status":"success"}],"config":{"defaultView":"all","baseHost":"","scaleImages":false,"lazyLoadOffset":800,"errorPatterns":[],"metaInfoBaseUrls":{}},"apiValues":{"extraItems":{},"metaInfoExtenders":{},"imagesSaver":{"saveImg":"async (srcCurrPath, {destPath, reportDir}) => {\n        await utils.copyImageAsync(srcCurrPath, destPath, reportDir);\n\n        return destPath;\n    }"}},"date":"Thu Nov 07 2019 16:10:43 GMT+0000 (Coordinated Universal Time)","total":1,"passed":1,"failed":0,"skipped":0,"retries":0,"perBrowser":{"PC":{"total":1,"passed":1,"failed":0,"skipped":0,"retries":0}}};
try { module.exports = data; } catch(e) {}