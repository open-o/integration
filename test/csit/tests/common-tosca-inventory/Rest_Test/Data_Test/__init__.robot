*** Settings ***
Suite Setup       Create Session    inventory    http://10.74.24.149:8203/inventory
Library           collections
Library           RequestsLibrary
Library           json
Resource          ../Model_Test/keyword.txt
Resource          keyword.txt
