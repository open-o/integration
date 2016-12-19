/*
 * Copyright 2016 Huawei Technologies Co., Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.openo.sdno.testframework.topology.datahandler;

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.MediaType;

import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.type.TypeReference;
import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.baseservice.roa.util.restclient.RestfulParametes;
import org.openo.baseservice.roa.util.restclient.RestfulResponse;
import org.openo.sdno.testframework.http.model.HttpConstants;
import org.openo.sdno.testframework.topology.ResourceType;
import org.openo.sdno.testframework.util.file.FileUtils;
import org.openo.sdno.testframework.util.file.JsonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Class of NetworkElement Data handler.<br>
 * 
 * @author
 * @version SDNO 0.5 2016-5-5
 */
public class NetworkElementDataHandler extends TopoDataHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(NetworkElementDataHandler.class);

    private static final String NE_URI = "/openoapi/sdnobrs/v1/managed-elements";

    private static final String MO_KEY = "managedElement";

    private static final String CONTROLLER_NAME_KEY = "controllerName";

    private static final String CONTROLLER_ID_KEY = "controllerID";

    private static final String SITE_NAME_KEY = "siteName";

    private static final String SITE_ID_KEY = "siteID";

    @Override
    public void addResource(File file) throws ServiceException {

        String jsonContent = FileUtils.readFromJson(file);

        List<Map<String, Object>> neResourceMapList =
                JsonUtil.fromJson(jsonContent, new TypeReference<List<Map<String, Object>>>() {});
        for(Map<String, Object> curResource : neResourceMapList) {
            String resourceName = (String)curResource.get(NAME_KEY);
            if(StringUtils.isEmpty(resourceName)) {
                LOGGER.error("Add NetworkElement Resource occurs Error!!");
                throw new ServiceException("Add NetworkElement Resource occurs Error");
            }

            setController(curResource);

            setSite(curResource);

            Map<String, Object> bodyMap = new HashMap<String, Object>();
            bodyMap.put(MO_KEY, curResource);

            RestfulParametes restParams = new RestfulParametes();
            restParams.putHttpContextHeader("Content-Type", MediaType.APPLICATION_JSON);
            restParams.setRawData(JsonUtil.toJson(bodyMap));

            RestfulResponse response = restClient.post(NE_URI, restParams);
            if(!HttpConstants.isSucess(response.getStatus()) || StringUtils.isEmpty(response.getResponseContent())) {
                LOGGER.error("Add NetworkElement Resource occurs Error!!");
                throw new ServiceException("Add NetworkElement Resource occurs Error");
            }
            Map<String, Map<String, String>> objectMap = JsonUtil.fromJson(response.getResponseContent(),
                    new TypeReference<Map<String, Map<String, String>>>() {});
            Map<String, String> networkElementObject = objectMap.get(MO_KEY);
            if(null == networkElementObject) {
                LOGGER.error("networkElementObject is null!!");
                throw new ServiceException("networkElementObject is null!!");
            }
            String objectId = networkElementObject.get(ID_KEY);
            if(StringUtils.isEmpty(objectId)) {
                LOGGER.error("networkElement ObjectID is null!!");
                throw new ServiceException("networkElement ObjectID is null!!");
            }

            dataCache.addUUIDToMap(ResourceType.NETWORKELEMENT, resourceName, objectId);
        }
    }

    @Override
    public void removeResource() throws ServiceException {

        Map<String, String> dataMap = dataCache.getDataMapbyResouceType(ResourceType.NETWORKELEMENT);
        for(String objectId : dataMap.values()) {
            RestfulParametes restParams = new RestfulParametes();
            restParams.putHttpContextHeader("Content-Type", MediaType.APPLICATION_JSON);
            RestfulResponse response = restClient.delete(NE_URI + "/" + objectId, restParams);
            if(!HttpConstants.isSucess(response.getStatus())) {
                LOGGER.error("delete NetworkElement " + objectId + " failed!!");
            }
        }

        dataCache.removeResourceData(ResourceType.NETWORKELEMENT);
    }

    private void setSite(Map<String, Object> curResource) throws ServiceException {
        String siteName = (String)curResource.get(SITE_NAME_KEY);
        if(!StringUtils.isEmpty(siteName)) {
            String siteID = dataCache.getUUIDbyName(ResourceType.SITE, siteName);
            if(StringUtils.isEmpty(siteID)) {
                LOGGER.error("Site ID is Empty!!");
                throw new ServiceException("Site ID is Empty!!");
            }
            List<String> siteIDList = Collections.singletonList(siteID);
            curResource.put(SITE_ID_KEY, siteIDList);
            curResource.remove(SITE_NAME_KEY);
        }
    }

    private void setController(Map<String, Object> curResource) throws ServiceException {
        String controllerName = (String)curResource.get(CONTROLLER_NAME_KEY);
        if(!StringUtils.isEmpty(controllerName)) {
            String controllerID = dataCache.getUUIDbyName(ResourceType.CONTROLLER, controllerName);
            if(StringUtils.isEmpty(controllerID)) {
                LOGGER.error("Controller ID is Empty!!");
                throw new ServiceException("Controller ID is Empty!!");
            }
            List<String> controllerIDList = Collections.singletonList(controllerID);
            curResource.put(CONTROLLER_ID_KEY, controllerIDList);
            curResource.remove(CONTROLLER_NAME_KEY);
        }
    }

}
