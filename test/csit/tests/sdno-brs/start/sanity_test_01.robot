*** settings ***
Library  Collections
Library  requests

*** test cases ***
simpleRequest
    ${result} =  get  http://${MSB_IP}/openoapi/sdnobrs/v1/sites
    Should Be Equal  ${result.status_code}  ${200}
    ${json} =  Set Variable  ${result.json()}
	${totalNum} =  Get From Dictionary  ${json}  totalNum
    Should Be Equal As Integers  ${totalNum}  0
	${pageSize} =  Get From Dictionary  ${json}  pageSize
    Should Be Equal As Integers   ${pageSize}  1000
	${currentPageNum} =  Get From Dictionary  ${json}  currentPageNum
    Should Be Equal As Integers   ${currentPageNum}  0
	${sites} =  Get From Dictionary  ${json}  sites
    Should Be Empty   ${sites}
	${totalPageNum} =  Get From Dictionary  ${json}  totalPageNum
    Should Be Equal As Integers   ${totalPageNum}  0
	BuiltIn.Log    ${json}
	
	