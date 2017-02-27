*** Settings ***
Suite Setup       Create Session    inventory    http://${INVENTORY_IP}:8203/inventory
Library           collections
Library           RequestsLibrary
Library           json
Resource          ../Model_Test/keyword.txt
Resource          keyword.txt
