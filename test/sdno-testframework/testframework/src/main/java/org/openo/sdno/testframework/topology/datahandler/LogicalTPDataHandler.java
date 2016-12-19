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
 * Class if LogicalTernminationPoint data handler.<br>
 * 
 * @author
 * @version SDNO 0.5 2016-07-18
 */
public class LogicalTPDataHandler extends TopoDataHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(LogicalTPDataHandler.class);

    private static final String LTP_URI = "/openoapi/sdnobrs/v1/logical-termination-points";

    private static final String NENAME_KEY = "neName";

    private static final String MEID_KEY = "meID";

    private static final String MO_KEY = "logicalTerminationPoint";

    @Override
    public void addResource(File file) throws ServiceException {

        String jsonContent = FileUtils.readFromJson(file);

        List<Map<String, Object>> portResourceMapList =
                JsonUtil.fromJson(jsonContent, new TypeReference<List<Map<String, Object>>>() {});
        for(Map<String, Object> curResource : portResourceMapList) {
            String resourceName = (String)curResource.get(NAME_KEY);
            if(StringUtils.isEmpty(resourceName)) {
                LOGGER.error("Add Ltp Resource occurs Error!!");
                throw new ServiceException("Add Ltp Resource occurs Error");
            }

            String neName = (String)curResource.get(NENAME_KEY);
            if(!StringUtils.isEmpty(neName)) {
                String neID = dataCache.getUUIDbyName(ResourceType.NETWORKELEMENT, neName);
                if(StringUtils.isEmpty(neID)) {
                    LOGGER.error("NetworkElement ID is Empty!!");
                    throw new ServiceException("NetworkElement ID is Empty!!");
                }
                curResource.put(MEID_KEY, neID);
                curResource.remove(NENAME_KEY);
            }

            Map<String, Object> bodyMap = new HashMap<String, Object>();
            bodyMap.put(MO_KEY, curResource);

            RestfulParametes restParams = new RestfulParametes();
            restParams.putHttpContextHeader("Content-Type", MediaType.APPLICATION_JSON);
            restParams.setRawData(JsonUtil.toJson(bodyMap));

            RestfulResponse response = restClient.post(LTP_URI, restParams);
            if(!HttpConstants.isSucess(response.getStatus()) || StringUtils.isEmpty(response.getResponseContent())) {
                LOGGER.error("Add Ltp Resource occurs Error!!");
                throw new ServiceException("Add Ltp Resource occurs Error");
            }
            Map<String, Map<String, String>> objectMap = JsonUtil.fromJson(response.getResponseContent(),
                    new TypeReference<Map<String, Map<String, String>>>() {});
            Map<String, String> ltpObject = objectMap.get(MO_KEY);
            if(null == ltpObject) {
                LOGGER.error("ltpObject is null!!");
                throw new ServiceException("ltpObject is null!!");
            }

            String objectId = ltpObject.get(ID_KEY);
            if(StringUtils.isEmpty(objectId)) {
                LOGGER.error("networkElement ObjectID is null!!");
                throw new ServiceException("networkElement ObjectID is null!!");
            }

            dataCache.addUUIDToMap(ResourceType.LOGICALTERMINATIONPOINT, resourceName, objectId);
        }
    }

    @Override
    public void removeResource() throws ServiceException {
        Map<String, String> dataMap = dataCache.getDataMapbyResouceType(ResourceType.LOGICALTERMINATIONPOINT);

        for(String objectId : dataMap.values()) {
            RestfulParametes restParams = new RestfulParametes();
            restParams.putHttpContextHeader("Content-Type", MediaType.APPLICATION_JSON);
            RestfulResponse response = restClient.delete(LTP_URI + "/" + objectId, restParams);
            if(!HttpConstants.isSucess(response.getStatus())) {
                LOGGER.error("delete ltp " + objectId + " failed!!");
            }
        }

        dataCache.removeResourceData(ResourceType.LOGICALTERMINATIONPOINT);
    }
}
