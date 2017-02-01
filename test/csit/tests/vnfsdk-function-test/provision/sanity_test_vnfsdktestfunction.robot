*** settings ***
Library           Remote    http://127.0.0.1:8271

*** Variables ***
${vnfsdktestfunc}    jsoninput/vnfsdktestfunc.json

*** Test Cases ***
vnfsdkfunctest
    [Documentation]    VNFSDKFunctionTest
    Send REST and get Value    ${vnfsdktestfunc}    null
