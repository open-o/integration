*** Settings ***
Suite Setup       Create Session    inventory    http://10.74.24.149:8203/inventory
Resource          keyword.txt
Library           RequestsLibrary
Library           Collections
Library           json
