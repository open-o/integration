*** Settings ***
Suite Setup       Create Session    inventory    http://${INVENTORY_IP}:8203/inventory
Resource          keyword.txt
Library           RequestsLibrary
Library           Collections
Library           json
