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
import java.text.MessageFormat;
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
import org.openo.sdno.testframework.util.EncryptionUtil;
import org.openo.sdno.testframework.util.file.FileUtils;
import org.openo.sdno.testframework.util.file.JsonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Class of CommParam Data handler.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 22, 2016
 */
public class CommParamDataHandler extends TopoDataHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(CommParamDataHandler.class);

    private static final String COMMPARAM_URL = "/openoapi/sdnobrs/v1/commparammgmt/access-objects/{0}/commparams";

    private static final String CONTROLLER_NAME_KEY = "controllerName";

    private static final String COMMPARAM_KEY = "commparam";

    @Override
    public void addResource(File file) throws ServiceException {

        String jsonContent = FileUtils.readFromJson(file);

        List<Map<String, String>> commparamResourceMapList =
                JsonUtil.fromJson(jsonContent, new TypeReference<List<Map<String, String>>>() {});
        for(Map<String, String> curResource : commparamResourceMapList) {

            String resourceName = curResource.get(NAME_KEY);
            if(StringUtils.isEmpty(resourceName)) {
                LOGGER.error("Commparam do not hava name!!");
                throw new ServiceException("Commparam do not hava name!!");
            }

            String controllerName = curResource.get(CONTROLLER_NAME_KEY);
            if(StringUtils.isEmpty(controllerName)) {
                LOGGER.error("Controller Name is Empty");
                throw new ServiceException("Controller Name is Empty");
            }

            // Get related controller
            String controllerId = dataCache.getUUIDbyName(ResourceType.CONTROLLER, controllerName);
            if(StringUtils.isEmpty(controllerId)) {
                LOGGER.error("Controller Id is Empty");
                throw new ServiceException("Controller Id is Empty");
            }

            curResource.put("objectId", controllerId);
            char[] encodedParam = EncryptionUtil.encode(curResource.get("commParams").toCharArray());
            curResource.put("commParams", new String(encodedParam));

            // need to remove this attribute
            curResource.remove(CONTROLLER_NAME_KEY);
            curResource.remove(NAME_KEY);

            Map<String, Object> mapBody = new HashMap<String, Object>();
            mapBody.put(COMMPARAM_KEY, curResource);

            String body = JsonUtil.toJson(mapBody);
            String createUrl = MessageFormat.format(COMMPARAM_URL, controllerId);

            RestfulParametes restParams = new RestfulParametes();
            restParams.putHttpContextHeader("Content-Type", MediaType.APPLICATION_JSON);
            restParams.setRawData(body);

            RestfulResponse response = restClient.post(createUrl, restParams);
            if(!HttpConstants.isSucess(response.getStatus()) || StringUtils.isEmpty(response.getResponseContent())) {
                LOGGER.error("Add CommParam Resource occurs Error!!");
                throw new ServiceException("Add CommParam Resource occurs Error");
            }

            String objectID = response.getResponseContent();
            if(null == objectID) {
                LOGGER.error("Add CommParam Resource do not GetID!!");
                throw new ServiceException("Add CommParam Resource do not GetID!!");
            }

            dataCache.addUUIDToMap(ResourceType.COMM_PARAM, resourceName, objectID);
        }
    }

    @Override
    public void removeResource() throws ServiceException {
        Map<String, String> dataMap = dataCache.getDataMapbyResouceType(ResourceType.CONTROLLER);
        for(String objectId : dataMap.values()) {
            String deleteUrl = MessageFormat.format(COMMPARAM_URL, objectId);
            RestfulParametes restParams = new RestfulParametes();
            restParams.putHttpContextHeader("Content-Type", MediaType.APPLICATION_JSON);
            RestfulResponse response = restClient.delete(deleteUrl, restParams);
            if(!HttpConstants.isSucess(response.getStatus())) {
                LOGGER.error("delete CommParam " + objectId + " failed!!");
            }
        }

        dataCache.removeResourceData(ResourceType.COMM_PARAM);
    }
}
