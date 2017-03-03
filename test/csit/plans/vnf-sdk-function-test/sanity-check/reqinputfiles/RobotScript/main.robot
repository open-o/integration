*** Settings ***
Suite Teardown    Close All Connections
Library           String
Library           OperatingSystem
Library           SSHLibrary
Library           BuiltIn
Library           Collections

*** Test Cases ***
Ping Remote Machine
    ${PingResult} =   Run    ping ${SUT} -c 4
    Should Contain    ${PingResult}    4 received

Open SSH Connection to Remote machine
    Open Connection    ${SUT}    ${SUT_NAME}
    Login    ${SUT_USERNAME}     ${SUT_PASSWORD} 

Block ICMP ping from Test machine  
    ${PingResult} =    Execute Command    iptables -A INPUT -p icmp -s ${TEST_MACHINE} --icmp-type 8 -j DROP

Ping Remote Machine Should Fail
    ${PingResult} =    Run    ping ${SUT} -c 4
    Should Contain    ${PingResult}    0 received

UnBlock ICMP ping from Test machine
    ${PingResult} =    Execute Command    iptables -D INPUT -p icmp -s ${TEST_MACHINE} --icmp-type 8 -j DROP

Ping Remote Machine Should Now Pass
    ${PingResult} =    Run    ping ${SUT} -c 4
    Should Contain    ${PingResult}    4 received

