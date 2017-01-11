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

package org.openo.sdno.testframework.topology;

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.testframework.checker.JsonSchemaValidator;
import org.openo.sdno.testframework.http.model.HttpModelUtils;
import org.openo.sdno.testframework.http.model.HttpRequest;
import org.openo.sdno.testframework.http.model.HttpResponse;
import org.openo.sdno.testframework.http.model.HttpRquestResponse;
import org.openo.sdno.testframework.testmanager.TestManager;
import org.openo.sdno.testframework.util.file.FileUtils;
import org.openo.sdno.testframework.util.file.JsonFileNameFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Topology Operation Class.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 17, 2016
 */
public class Topology extends TestManager {

    private static final Logger LOGGER = LoggerFactory.getLogger(Topology.class);

    private String topoFileDir;

    private String resourceId;

    private File file;

    private Map<String, String> mapOfElements;

    private TopologyOperation topoOperation;

    Map<String, Map<String, String>> mapOfTopoElements = new HashMap<String, Map<String, String>>();

    private static final Map<String, String> TypeMap;
    static {
        Map<String, String> aMap = new HashMap<String, String>();
        aMap.put("NEelement", "id");
        aMap.put("Controller", "controllerId");
        TypeMap = Collections.unmodifiableMap(aMap);
    }

    /**
     * Constructor<br>
     * 
     * @param topoFileDir topoFile Directory
     * @since SDNO 0.5
     */
    public Topology(String topoFileDir) {
        this.topoFileDir = topoFileDir;
        this.topoOperation = new TopologyOperation();
    }

    /**
     * Create Topology.<br>
     * 
     * @throws ServiceException when create topology failed
     * @since SDNO 0.5
     */
    public void createTopology() throws ServiceException {
        if(StringUtils.isBlank(topoFileDir)) {
            LOGGER.error("topoFile Dir parameter is invalid!!");
            throw new ServiceException("topoFileDir is invalid!!");
        }

        List<File> resFileList = FileUtils.listAllFiles(new File(this.topoFileDir), new JsonFileNameFilter());
        topoOperation.addResourceData(resFileList);
    }

    /**
     * Create Inventory Topology.<br>
     * 
     * @throws ServiceException when create topology failed
     * @since SDNO 0.5
     */
    public void createInvTopology() throws ServiceException {
        if(StringUtils.isBlank(topoFileDir)) {
            LOGGER.error("topoFile Dir parameter is invalid!!");
            throw new ServiceException("topoFileDir is invalid!!");
        }

        List<File> resFileList = FileUtils.listAllFiles(new File(this.topoFileDir), new JsonFileNameFilter());
        topoOperation.addInvResourceData(resFileList);
    }

    /**
     * Create Inventory Resources.<br>
     * 
     * @throws ServiceException when create topology failed
     * @since Integration 2.0
     */
    public void createResources() throws ServiceException {
        if(StringUtils.isBlank(topoFileDir)) {
            LOGGER.error("topoFile Dir parameter is invalid!!");
            throw new ServiceException("topoFileDir is invalid!!");
        }

        List<File> resFileList = FileUtils.listAllFiles(new File(this.topoFileDir), new JsonFileNameFilter());

        Map<String, String> mapOfElements = new HashMap<String, String>();
        for(File file : resFileList) {
            String path = file.getParent();
            String directoryName = path.substring(path.lastIndexOf("\\") + 1, path.length());
            resourceId = doOperationAndGetValue(file.getAbsolutePath(), TypeMap.get(directoryName));
            mapOfElements.put(file.getName(), resourceId);
        }

        mapOfTopoElements.put(topoFileDir, mapOfElements);
    }

    public String doOperationAndGetValue(String queryPath, String variable) throws ServiceException {
        HttpRquestResponse httpCreateObject = HttpModelUtils.praseHttpRquestResponseFromFile(queryPath);
        HttpRequest createRequest = httpCreateObject.getRequest();
        HttpResponse createResponse =
                execTestCase(createRequest, new JsonSchemaValidator(httpCreateObject.getResponse()));
        String resourceId = getObject(variable, createResponse.getData());

        return resourceId;

    }

    public String getObject(String key, String JSON) {
        Pattern p = Pattern.compile(String.format("\"%s\":\"(.*?)\"", key));
        Matcher matcher = p.matcher(JSON);
        if(matcher.find()) {
            Pattern resource = Pattern.compile(String.format(":\"(.*?)\"", key));
            Matcher match = resource.matcher(matcher.group());
            if(match.find()) {
                return match.group().substring(1).replaceAll("\"", "");
            }
        }
        return null;
    }

    /**
     * Clear All Topology Resource Data.<br>
     * 
     * @throws ServiceException when clear topology failed
     * @since SDNO 0.5
     */
    public void clearTopology() throws ServiceException {

        topoOperation.removeResourceData();
    }

    /**
     * Clear All Inventory Topology Resource Data.<br>
     * 
     * @throws ServiceException when clear topology failed
     * @since SDNO 0.5
     */
    public void clearInvTopology() throws ServiceException {
        topoOperation.removeInvResourceData();
    }

    public void clearResources() throws ServiceException {

        if(StringUtils.isBlank(topoFileDir)) {
            LOGGER.error("topoFile Dir parameter is invalid!!");
            throw new ServiceException("topoFileDir is invalid!!");
        }

        List<File> resFileList = FileUtils.listAllFiles(new File(this.topoFileDir), new JsonFileNameFilter());

        Map<String, String> FileNameToId = mapOfTopoElements.get(topoFileDir);
        if(null == FileNameToId) {
            // log error
            return;
        }

        // Loop all the files, and get corresponding resource Id and send delete request
        for(File resFile : resFileList) {
            String resourceId = FileNameToId.get(resFile.getName());

            // We have to append URI with Id and change the method to Delete and send.
            HttpRquestResponse httpDelObject =
                    HttpModelUtils.praseHttpRquestResponseFromFile(resFile.getAbsolutePath());
            HttpRequest httpRequest = httpDelObject.getRequest();

            // Apppend the resource Id for delete request to delete the resource
            httpRequest.setMethod("delete");
            httpRequest.setUri(httpRequest.getUri() + "/" + resourceId);

            // Make data has empty
            httpRequest.setData("");

            // Send the delete request and verify the response (only error code);
            httpDelObject.getResponse().setStatus(200);
            httpDelObject.getResponse().setData("");
            HttpResponse delResponse = execTestCase(httpRequest, new JsonSchemaValidator(httpDelObject.getResponse()));
        }

    }

    /**
     * Get resource uuid.<br>
     * 
     * @param resourceType resource type
     * @param resourceName resource name
     * @return resource uuid
     * @since SDNO 0.5
     */
    public String getResourceUuid(ResourceType resourceType, String resourceName) {
        return topoOperation.getResourceUuid(resourceType, resourceName);
    }
}
