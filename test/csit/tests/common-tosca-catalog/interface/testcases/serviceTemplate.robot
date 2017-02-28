*** Settings ***
Force Tags        CRUDcatalog
Library           json
Library           requests
Library           Collections
Library           RequestsLibrary
Resource          ../libraries/common/common.robot
Resource          ../libraries/catalog/servicetemplates.robot

*** Test Cases ***
queryServiceTemplateByFilterConditions
    [Tags]    queryServiceTemplateByFilterConditions
    queryServiceTemplateByFilterConditions

queryNestingServiceTemplateByNodeType
    [Tags]    queryNestingServiceTemplateByNodeType
    queryNestingServiceTemplateByNodeType

queryRawDataServiceTemplateBycsarId
    [Tags]    queryRawDataServiceTemplateBycsarId
    queryRawDataServiceTemplateBycsarId

queryeNodeTemplateByServiceTemplatId
    [Tags]    queryeNodeTemplateByServiceTemplatId
    queryeNodeTemplateByServiceTemplatId

queryeNodeTemplateByServiceTemplatIdAndTypes
    [Tags]    queryeNodeTemplateByServiceTemplatIdAndTypes
    queryeNodeTemplateByServiceTemplatIdAndTypes

queryNodeTemplateByServiceTemplatIdAndNodeTemplateId
    [Tags]    queryNodeTemplateByServiceTemplatIdAndNodeTemplateId
    queryNodeTemplateByServiceTemplatIdAndNodeTemplateId

queryOperationByServiceTemplatId
    [Tags]    queryOperationByServiceTemplatId
    queryOperationByServiceTemplatId

queryServiceTemplatByServiceTemplatId
    [Tags]    queryServiceTemplatByServiceTemplatId
    queryServiceTemplatByServiceTemplatId

queryInputParametersByServiceTemplatId
    [Tags]    queryInputParametersByServiceTemplatId
    queryInputParametersByServiceTemplatId
