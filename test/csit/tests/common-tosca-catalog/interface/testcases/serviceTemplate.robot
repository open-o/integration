*** Settings ***
Force Tags        CRUDcatalog
Library           json
Library           requests
Library           Collections
Library           RequestsLibrary
Resource          ../libraries/common/common.robot
Resource          ../libraries/catalog/servicetemplates.robot

*** Test Cases ***


queryNestingServiceTemplateByNodeType
    [Tags]    queryNestingServiceTemplateByNodeType
    queryNestingServiceTemplateByNodeType

