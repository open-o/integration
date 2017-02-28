*** Settings ***
Resource          ../../variables/variable.robot
Resource          ../common/common.robot
Resource          ../assert/assert-contain.robot
Library           json
Library           String
Library           OperatingSystem
Resource          csars.robot

*** Variables ***
${serviceTemplateId}    ${empty}
${model_uri}      servicetemplates
${nodeTypeIds}    tosca.nodes.nfv.ext.zte.VNF.tseti
${service_csars_Id}    ${empty}
${operationName}    ${empty}
${nodeTemplateId}    ${empty}

*** Keywords ***
queryServiceTemplateByFilterConditions
    #    upload data
    ${csar_id_temp}    uploadCsaPackage
    #    Query data
    rest.createsession
    ${status}    SET variable
    ${deletionPending}    SET variable
    ${params}    catenate    SEPARATOR=&
    ${resp}=    Get Request    openo    ${LOCAL_CATALOG_PATH}/${model_uri}
    Should Be Equal As Strings    ${resp.status_code}    200
    @{content}    to json    ${resp.content}
    : FOR    ${temp_content}    IN    @{content}
    \    ${serviceTemplateId}    get from dictionary    ${temp_content}    serviceTemplateId
    \    ${service_csars_Id}    get from dictionary    ${temp_content}    csarid
    \    run keyword if    '${service_csars_Id}'=='${csar_id_temp}'    Exit For Loop
    Should Be Equal As Strings    '${service_csars_Id}'    '${csar_id_temp}'
    content-list-size-greater    ${resp}    1    200
    ${service_csars_Id}    set global variable    ${service_csars_Id}
    ${serviceTemplateId}    set global variable    ${serviceTemplateId}

queryNestingServiceTemplateByNodeType
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/nesting?nodeTypeIds=${nodeTypeIds}
    log    ${resp}
    status-code    ${resp}    200
    ${content}    to json    ${resp.content}
    content-list-size-greater    ${resp}    1    200

queryRawDataServiceTemplateBycsarId
    log    ${service_csars_Id}
    ${inputParameters}    SET variable
    ${body}    Create Dictionary    csarId=${service_csars_Id}
    ${resp}    REST.postRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/queryingrawdata    ${body}
    log    ${resp.content}
    status-code    ${resp}    200
    content-list-size-greater    ${resp}    1    200

queryeNodeTemplateByServiceTemplatId
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/${serviceTemplateId}/nodetemplates
    log    ${resp}
    status-code    ${resp}    200
    content-list-size-greater    ${resp}    1    200
    @{detail}    to json    ${resp.content}
    ${nodeTemplateId}    get from dictionary    @{detail}    id
    ${nodeTemplateId}    set global variable    ${nodeTemplateId}

queryeNodeTemplateByServiceTemplatIdAndTypes
    ${types}    SET variable
    ${params}    Create Dictionary    types=${types}
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/${serviceTemplateId}?${params}
    log    ${resp}
    Should Be Equal As Strings    ${resp.status_code}    200
    content-list-size-greater    ${resp}    1    200

queryNodeTemplateByServiceTemplatIdAndNodeTemplateId
    log    ${nodeTemplateId}
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/${serviceTemplateId}/nodetemplates/${nodeTemplateId}
    log    ${resp}
    status-code    ${resp}    200
    content-list-size-greater    ${resp}    1    200

queryOperationByServiceTemplatId
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/${serviceTemplateId}/operations
    log    ${resp}
    status-code    ${resp}    200

queryByServiceTemplatIdAndOperationName
    ${operationName}    set variable    tosca.nodes.nfv.ext.zte.VNF.tseti
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/${serviceTemplateId}/operations/${operationName}/parameters
    log    ${resp}
    status-code    ${resp}    200

queryServiceTemplatByServiceTemplatId
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/${serviceTemplateId}
    log    ${resp}
    Should Be Equal As Strings    ${resp.status_code}    200
    content-list-size-greater    ${resp}    1    200

queryInputParametersByServiceTemplatId
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/${model_uri}/${serviceTemplateId}/parameters
    log    ${resp.content}
    status-code    ${resp}    200
    #    delete the data of upload
    ${csar_id}    set variable    ${service_csars_Id}
    deleteCsarById
