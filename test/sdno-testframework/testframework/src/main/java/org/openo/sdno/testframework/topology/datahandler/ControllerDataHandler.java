/*
 * Copyright 2016-2017 Huawei Technologies Co., Ltd.
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
 * Class of Controller Data Handler.<br>
 * 
 * @author
 * @version SDNO 0.5 2016-5-4
 */
public class ControllerDataHandler extends TopoDataHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(ControllerDataHandler.class);

    private static final String CONTROLLER_URL = "/openoapi/extsys/v1/sdncontrollers";

    private static final String CONTROLLERID_KEY = "sdnControllerId";

    @Override
    public void addResource(File file) throws ServiceException {

        String jsonContent = FileUtils.readFromJson(file);

        List<Map<String, String>> controllerResourceMapList =
                JsonUtil.fromJson(jsonContent, new TypeReference<List<Map<String, String>>>() {});
        for(Map<String, String> curResource : controllerResourceMapList) {
            String resourceName = curResource.get(NAME_KEY);
            if(StringUtils.isEmpty(resourceName)) {
                LOGGER.error("Add Controller Resource occurs Error");
                throw new ServiceException("Add Controller Resource occurs Error");
            }

            RestfulParametes restParams = new RestfulParametes();
            restParams.putHttpContextHeader("Content-Type", MediaType.APPLICATION_JSON);
            restParams.setRawData(JsonUtil.toJson(curResource));

            RestfulResponse response = restClient.post(CONTROLLER_URL, restParams);
            if(!HttpConstants.isSucess(response.getStatus()) || StringUtils.isEmpty(response.getResponseContent())) {
                LOGGER.error("Add Controller Resource occurs Error!!");
                throw new ServiceException("Add Controller Resource occurs Error");
            }

            Map<String, String> resultObjectMap =
                    JsonUtil.fromJson(response.getResponseContent(), new TypeReference<Map<String, String>>() {});

            String objectID = resultObjectMap.get(CONTROLLERID_KEY);
            if(null == objectID) {
                LOGGER.error("Add Controller Resource do not GetID!!");
                throw new ServiceException("Add Controller Resource do not GetID!!");
            }

            dataCache.addUUIDToMap(ResourceType.CONTROLLER, resourceName, objectID);
        }
    }

    @Override
    public void removeResource() throws ServiceException {
        Map<String, String> dataMap = dataCache.getDataMapbyResouceType(ResourceType.CONTROLLER);
        for(String objectId : dataMap.values()) {
            RestfulParametes restParams = new RestfulParametes();
            restParams.putHttpContextHeader("Content-Type", MediaType.APPLICATION_JSON);
            RestfulResponse response = restClient.delete(CONTROLLER_URL + "/" + objectId, restParams);
            if(!HttpConstants.isSucess(response.getStatus())) {
                LOGGER.error("delete Controller " + objectId + " failed!!");
            }
        }

        dataCache.removeResourceData(ResourceType.CONTROLLER);
    }
}
