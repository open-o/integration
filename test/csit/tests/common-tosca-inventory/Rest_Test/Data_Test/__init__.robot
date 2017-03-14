*** Settings ***
Suite Setup       Create Session    inventory    http://${MSB_IP}
Library           collections
Library           RequestsLibrary
Library           json
Resource          ../Model_Test/keyword.txt
Resource          keyword.txt
