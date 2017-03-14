*** Settings ***
Suite Setup       Create Session    inventory    http://${MSB_IP}
Resource          keyword.txt
Library           RequestsLibrary
Library           Collections
Library           json
