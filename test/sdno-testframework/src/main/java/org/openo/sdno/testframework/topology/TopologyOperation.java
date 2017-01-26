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
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.testframework.topology.datahandler.TopoDataHandler;
import org.openo.sdno.testframework.topology.datahandler.TopoDataHandlerFactory;

/**
 * Topology Operation Class.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 20, 2016
 */
public class TopologyOperation {

    private TopologyResourceManager topoResMgr;

    private TopologyResourceCache dataCache;

    private Map<ResourceType, TopoDataHandler> dataHandlerMap =
            new TreeMap<ResourceType, TopoDataHandler>(new Comparator<ResourceType>() {

                // Just use ENUM Sequence to decide execution Sequence
                @Override
                public int compare(ResourceType resourceType1, ResourceType resourceType2) {
                    return resourceType1.compareTo(resourceType2);
                }
            });

    /**
     * Constructor<br>
     * 
     * @since SDNO 0.5
     */
    public TopologyOperation() {
        topoResMgr = new TopologyResourceManager();
        dataCache = new TopologyResourceCache();
    }

    /**
     * Add Resource Data.<br>
     * 
     * @param fileList file need to process
     * @throws ServiceException throws when failed
     * @since SDNO 0.5
     */
    public void addResourceData(List<File> fileList) throws ServiceException {
        topoResMgr.setTopoResources(topoResMgr.retrieveTopoResources(fileList));
        topoResMgr.createJsonResources();
        topoResMgr.writeJsonResources();
    }

    /**
     * Add Inventory Resource Data<br>
     * 
     * @param fileList file need to process
     * @throws ServiceException throws when failed
     * @since SDNO 0.5
     */
    public void addInvResourceData(List<File> fileList) throws ServiceException {
        createDataHandler(fileList);
        processAddData();
    }

    /**
     * Remove Resource Data.<br>
     * 
     * @throws ServiceException throws when failed
     * @since SDNO 0.5
     */
    public void removeResourceData() throws ServiceException {
        // TODO
    }

    /**
     * Remove Inventory Resource Data.<br>
     * 
     * @throws ServiceException throws when failed
     * @since SDNO 0.5
     */
    public void removeInvResourceData() throws ServiceException {
        processRemoveData();
        dataHandlerMap.clear();
    }

    private void createDataHandler(List<File> fileList) {
        for(File curFile : fileList) {
            ResourceType curResourceType = getResourceTypeByFileName(curFile);
            if((null != curResourceType) && (null == dataHandlerMap.get(curResourceType))) {
                dataHandlerMap.put(curResourceType,
                        TopoDataHandlerFactory.getInstance().createDataHandler(curResourceType, dataCache));
                // Add Processing Files
                dataHandlerMap.get(curResourceType).addProcessFile(curFile);
            }
        }
    }

    private ResourceType getResourceTypeByFileName(File curFile) {
        String fileName = curFile.getName();
        return ResourceType.getResourceTypebyName(fileName);
    }

    private void processAddData() throws ServiceException {
        for(TopoDataHandler dataHandler : dataHandlerMap.values()) {
            dataHandler.processAddResource();
        }
    }

    private void processRemoveData() throws ServiceException {
        List<ResourceType> resourceTypeList = new ArrayList<ResourceType>(dataHandlerMap.keySet());
        Collections.sort(resourceTypeList, new Comparator<ResourceType>() {

            @Override
            public int compare(ResourceType resourceType1, ResourceType resourceType2) {
                return resourceType2.compareTo(resourceType1);
            }
        });
        for(ResourceType curResourceType : resourceTypeList) {
            dataHandlerMap.get(curResourceType).processRemoveResource();
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
        return dataCache.getUUIDbyName(resourceType, resourceName);
    }
}
